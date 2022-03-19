#!/usr/bin/env bash
#
# vim-openparent.sh
#
# vim のターミナル内から、親 vim でファイルを開くためのスクリプト。
#

if [ $# -ne 1 ];then
    echo "Usage: $0 FILE_PATH";
    exit 1
fi

echo -e "\x1b]51;[\"drop\", \"$1\"]\x07"

