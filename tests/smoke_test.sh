#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEST_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/stop-sauron-smoke.XXXXXX")"
STATE_DIR="$TEST_ROOT/state"
MOCK_BIN_DIR="$TEST_ROOT/mock-bin"
PLIST_ROOT="$TEST_ROOT/plists"
AGENT_DIR="$PLIST_ROOT/LaunchAgents"
DAEMON_DIR="$PLIST_ROOT/LaunchDaemons"
LIST_FILE="$TEST_ROOT/launchctl-list.txt"
ACTIONS_LOG="$TEST_ROOT/launchctl-actions.log"

cleanup() {
    rm -rf "$TEST_ROOT"
}

trap cleanup EXIT

mkdir -p "$STATE_DIR" "$MOCK_BIN_DIR" "$AGENT_DIR" "$DAEMON_DIR"
touch "$ACTIONS_LOG"

cat <<'EOF' > "$MOCK_BIN_DIR/launchctl"
#!/bin/bash
set -euo pipefail

command="${1:-}"
shift || true

case "$command" in
    list)
        if [[ -f "${STOP_SAURON_MOCK_LAUNCHCTL_LIST_FILE:-}" ]]; then
            cat "${STOP_SAURON_MOCK_LAUNCHCTL_LIST_FILE}"
        fi
        ;;
    load|unload)
        printf '%s %s\n' "$command" "$*" >> "${STOP_SAURON_MOCK_LAUNCHCTL_ACTIONS_LOG}"
        ;;
    *)
        printf 'unexpected launchctl command: %s\n' "$command" >&2
        exit 1
        ;;
esac
EOF

cat <<'EOF' > "$MOCK_BIN_DIR/su"
#!/bin/bash
set -euo pipefail

if [[ "${1:-}" == "-" ]]; then
    shift
fi

if [[ $# -lt 2 || "${2:-}" != "-c" ]]; then
    printf 'unexpected su invocation\n' >&2
    exit 1
fi

shift
shift
command="${1:-}"
bash -c "$command"
EOF

cat <<'EOF' > "$MOCK_BIN_DIR/ps"
#!/bin/bash
exit 0
EOF

cat <<'EOF' > "$MOCK_BIN_DIR/sw_vers"
#!/bin/bash
set -euo pipefail

case "${1:-}" in
    -productName)
        echo "macOS"
        ;;
    -productVersion)
        echo "15.5"
        ;;
    -buildVersion)
        echo "24F79"
        ;;
    *)
        echo "ProductName: macOS"
        echo "ProductVersion: 15.5"
        echo "BuildVersion: 24F79"
        ;;
esac
EOF

cat <<'EOF' > "$MOCK_BIN_DIR/sysctl"
#!/bin/bash
echo "hw.model: MacBookPro18,1"
EOF

cat <<'EOF' > "$MOCK_BIN_DIR/ioreg"
#!/bin/bash
echo '"IOPlatformSerialNumber" = "SMOKETEST123"'
EOF

chmod +x "$MOCK_BIN_DIR/launchctl" "$MOCK_BIN_DIR/su" "$MOCK_BIN_DIR/ps" "$MOCK_BIN_DIR/sw_vers" "$MOCK_BIN_DIR/sysctl" "$MOCK_BIN_DIR/ioreg"

touch "$AGENT_DIR/com.test.agent.plist" "$DAEMON_DIR/com.test.daemon.plist"
cat <<EOF > "$LIST_FILE"
123 0 com.test.agent
456 0 com.test.daemon
EOF

run_app() {
    local choice="$1"

    printf '%s\n' "$choice" | env \
        PATH="$MOCK_BIN_DIR:$PATH" \
        STOP_SAURON_TEST_EUID_OVERRIDE=0 \
        STOP_SAURON_LAUNCHCTL_BIN="$MOCK_BIN_DIR/launchctl" \
        STOP_SAURON_STATE_DIR="$STATE_DIR" \
        STOP_SAURON_PLIST_PATHS="$AGENT_DIR:$DAEMON_DIR" \
        STOP_SAURON_APPLICATIONS="com.test.agent:com.test.daemon" \
        STOP_SAURON_MOCK_LAUNCHCTL_LIST_FILE="$LIST_FILE" \
        STOP_SAURON_MOCK_LAUNCHCTL_ACTIONS_LOG="$ACTIONS_LOG" \
        SUDO_USER="smoketest" \
        "$REPO_DIR/stop-sauron"
}

assert_file_contains() {
    local file="$1"
    local pattern="$2"

    if ! grep -Fq -- "$pattern" "$file"; then
        printf 'expected %s to contain %s\n' "$file" "$pattern" >&2
        exit 1
    fi
}

assert_exists() {
    local path="$1"

    if [[ ! -f "$path" ]]; then
        printf 'expected file to exist: %s\n' "$path" >&2
        exit 1
    fi
}

run_app 6 >/dev/null
assert_exists "$STATE_DIR/plist-agent.backup.conf"
assert_exists "$STATE_DIR/plist-deamon.backup.conf"
assert_file_contains "$STATE_DIR/plist-agent.backup.conf" "$AGENT_DIR/com.test.agent.plist"
assert_file_contains "$STATE_DIR/plist-deamon.backup.conf" "$DAEMON_DIR/com.test.daemon.plist"

run_app 5 >/dev/null
assert_exists "$STATE_DIR/plist-agent.backup.conf.bak"
assert_exists "$STATE_DIR/plist-deamon.backup.conf.bak"

run_app 1 >/dev/null
assert_file_contains "$ACTIONS_LOG" "unload -w $DAEMON_DIR/com.test.daemon.plist"
assert_file_contains "$ACTIONS_LOG" "unload -w $AGENT_DIR/com.test.agent.plist"

echo "Smoke test passed."
