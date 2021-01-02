# Development

To enable you doing development the scripts we creates some supporting tools / setting to make your life easier.

## Tools to install

| Tool | Used for |
| --- | --- |
| iTerm2 | iTerm2 is a terminal emulator that does great things |
| Brew | This is our preferred Package Manager for macOS |
| iTermocil | iTermocil allows you to setup pre-configured layouts of windows and panes in iTerm2, having each open in a specified directory and execute specified commands |

## Installing the tools

### Installing iTerm2

Download the [installer](https://iterm2.com/downloads/stable/latest) and install iTerm2.
Further information about iTerm2 can be found [here](https://iterm2.com).

### Installing Brew

```bash
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

```

Further information about Brew can be found [here](https://brew.sh/).

### Installing iTermocil

```bash
# Install `itermocil` via Homebrew
$ brew update
$ brew install TomAnthony/brews/itermocil

# Create your layout directory
$ mkdir ~/.itermocil
```

Further information about iTermocil can be found [here](https://github.com/TomAnthony/itermocil).

## Scripts and settings

Here you can find/download the scripts or settings used during development

# Development

To enable you doing development the scripts we creates some supporting tools / setting to make your life easier.

## Tools to install

| Tool | Used for |
| --- | --- |
| iTerm2 | iTerm2 is a terminal emulator that does great things |
| Brew | This is our preferred Package Manager for macOS |
| iTermocil | iTermocil allows you to setup pre-configured layouts of windows and panes in iTerm2, having each open in a specified directory and execute specified commands |

## Installing the tools

### Installing iTerm2

Download the [installer](https://iterm2.com/downloads/stable/latest) and install iTerm2.
Further information about iTerm2 can be found [here](https://iterm2.com).

### Installing Brew

```bash
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

```

Further information about Brew can be found [here](https://brew.sh/).

### Installing iTermocil

```bash
# Install `itermocil` via Homebrew
$ brew update
$ brew install TomAnthony/brews/itermocil

# Create your layout directory
$ mkdir ~/.itermocil
```

Further information about iTermocil can be found [here](https://github.com/TomAnthony/itermocil).

## Scripts and settings

Here you can find/download the scripts or settings used during development

### Copy iTermocil configuration file

Copy the following [file](https://github.com/tr3kl0v/stop-sauron/blob/main/development/stop-sauron_development-panes.yml) to the iTermocil config folder.

```bash
# copy iTermocil config
$ cp ~/Workspace/stop-sauron/development/stop-sauron_development-panes.yml ~/.itermocil/stop-sauron_development-panes.yml
```

You can start the development views simply by executing;

```bash
# start views
$ itermocil stop-sauron_development-panes
```
