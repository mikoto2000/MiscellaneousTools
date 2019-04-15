# ColorTool.ps1
#
# ColorTool のインストールを行います。
#
# インストール先ディレクトリ: `$home\bin`
#
$ColorToolTempFile="$env:TEMP\ColorTool.zip"
$BinDir="$home\bin"

# 出力先ディレクトリの確認・生成
$DestDir=$BinDir
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# ColorTool.exe の存在確認
if (Test-Path "$DestDir\ColorTool.exe") {
    Write-Host "'$DestDir\ColorTool.exe' already exist."
} else {
    # ダウンロード
    Write-Host "download ColorTool.zip."
    Invoke-WebRequest -Uri https://github.com/Microsoft/console/releases/download/1810.02002/ColorTool.zip -OutFile $ColorToolTempFile

    # $home\bin に展開
    Write-Host "Expand ColorTool.zip to '$DestDir'."
    Expand-Archive -Path $ColorToolTempFile -DestinationPath $DestDir
}


# 色設定がプロファイルに存在していなければ設定を追加
$ColorToolCommand = "ColorTool.exe -q OneHalfDark"
if (-Not (Get-Content $profile | Select-String -Quiet $ColorToolCommand)) {
    Write-Output "$ColorToolCommand" | Out-File -Append -Encoding "UTF8" -FilePath $($profile)
}

# 後片付け
if (Test-Path $ColorToolTempFile) {
    Remove-Item $ColorToolTempFile
}


