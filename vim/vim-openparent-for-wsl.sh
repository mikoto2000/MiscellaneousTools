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

vim.exe --servername $VIM_SERVER --remote-send "<Cmd>wincmd W<CR><Cmd>e $(wslpath -w $1)<CR>"

