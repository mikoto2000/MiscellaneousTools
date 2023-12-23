#!/usr/bin/env bash
#
# vim-openparent-for-wsl.sh
#
# Usage:
#     vim-openparent-for-wsl.sh FILE_PATH [VIM_SERVER_NAME]
#
# WSL のターミナルから、ホストの vim server でファイルを開くためのスクリプト。
#
if [ $# -lt 1 ];then
    echo "Usage: $0 FILE_PATH [VIM_SERVER_NAME]";
    exit 1
fi

if [ "$2" == "" ];then
  VIM_SERVER=$(vim.exe --serverlist | head -n 1 | sed -e "s/\r//g")
else
  VIM_SERVER=$2
fi

if [ "$VIM_SERVER" == "" ];then
  gvim.exe $1
else
  gvim.exe --remote-send "<Cmd>split<CR>"
  gvim.exe --remote "$1"
fi

