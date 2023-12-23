#!/usr/bin/env bash
#
# vim-openparent-for-wsl.sh
#
# Usage:
#     vim-openparent-for-wsl.sh
#
# WSL のターミナルから、ホストの vim server でファイルを開くためのスクリプト。
#
gvim.exe --remote-send "<Cmd>split<CR>"
gvim.exe --remote "$1"

