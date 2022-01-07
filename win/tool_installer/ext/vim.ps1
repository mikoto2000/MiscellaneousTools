# vim.ps1
#
# vim のインストールを行います。
#
# インストールする Vim: https://github.com/vim/vim-win32-installer/releases
# インストール先ディレクトリ: `$home\app`

$VimDownloadUrl="https://github.com/vim/vim-win32-installer/releases/download/v8.2.4023/gvim_8.2.4023_x64.zip"
$VimZipName=[System.IO.Path]::GetFileName($VimDownloadUrl)
#
$VimTempDir="$env:TEMP\vim_tmp"
$VimZipPath="$env:TEMP\$VimZipName"

$VimDirName="vim82"

$DestDir="$home\app"


# 出力先ディレクトリの確認・生成
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# vim の存在確認
if (Test-Path "$DestDir\$VimDirName") {
    Write-Host "'$DestDir\$VimDirName' already exist."
} else {
    # ダウンロード
    Write-Host "download vim."
    Invoke-WebRequest -Uri $VimDownloadUrl -OutFile $VimZipPath

    # $home\app に展開
    Write-Host "Expand $VimZipName to '$DestDir'."
    Expand-Archive -Path $VimZipPath -DestinationPath $VimTempDir
    Move-Item -Path $VimTempDir\vim\$VimDirName -Destination $DestDir\$VimDirName
}


# 後片付け
if (Test-Path $VimZipPath) {
    Remove-Item $VimZipPath
}

if (Test-Path $VimTempDir) {
    Remove-Item -Recurse $VimTempDir
}


