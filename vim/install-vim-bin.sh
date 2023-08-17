#!/usr/bin/env sh
#
# install-vim-bin
#
# Usage:
#     install-vim-bin.sh INSTALL_PATH
#
#     INSTALL_PATH: vim-bin のインストール先. このディレクトリ内に `vim` ディレクトリを作って、そこに `AppRun` が配置される(default: /)

# 引数チェック
INSTALL_PATH="${1}"
if [ "$1" = '' ]; then
  INSTALL_PATH="/"
fi

# vim-bin の基本情報
OWNER="lxhillwind"
REPO="vim-bin"

# 最新版のダウンロード URL を組み立て
LATEST_VERSION_TAG=$(curl -s "https://api.github.com/repos/${OWNER}/${REPO}/releases/latest" | jq -r .tag_name)
FILE_NAME="vim-${LATEST_VERSION_TAG}-linux-x64.tar.xz"
LATEST_URL="https://github.com/${OWNER}/${REPO}/releases/download/${LATEST_VERSION_TAG}/${FILE_NAME}"

echo "start install vim to ${INSTALL_PATH}/vim/AppRun..."

# インストールディレクトリ作成
mkdir -p ${INSTALL_PATH}
if [ $? -ne 0 ]; then
  echo "インストールディレクトリ ${INSTALL_PATH} の作成に失敗しました"
  exit 1
fi

# インストール
cd ${INSTALL_PATH}
curl -sLO "${LATEST_URL}"
tar axf "${FILE_NAME}"

rm ${FILE_NAME}

echo "finished install vim to ${INSTALL_PATH}/vim/AppRun"

