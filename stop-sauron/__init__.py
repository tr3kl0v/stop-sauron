# -*- coding: utf-8 -*-

# Copyright (c) 2023, Vice President'. All rights reserved.
# Use of this source code is governed by a Unlicense license that can be found in the LICENSE file.

"""
Stop-Sauron is a program that has been created to harmless disable/enable software being pushed to your MacBooks by a Mobile Device Management (MDM) system written in Python. Supported platforms:
 - MacOS

Works with Python versions 2.7 and 3.4+.
"""

from __future__ import division

import functools
import os
import signal
import subprocess
import sys
import threading
import time

try:
    import pwd
except ImportError:
    pwd = None


