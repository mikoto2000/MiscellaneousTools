# Gradle.ps1
#
# Gradle のインストールを行います。
#
# インストールする Gradle: https://gradle.org/releases/
# インストール先ディレクトリ: `$home\app`

$Version="5.4"
$DirName="gradle-$Version"
$ZipName="$DirName.zip"
$DownloadUrl="https://services.gradle.org/distributions/gradle-5.4-bin.zip"

$TempZipPath="$env:TEMP\$ZipName"

$DestDir="$home\app"

$AdditionalPath="$DestDir\$DirName\bin"


# 出力先ディレクトリの確認・生成
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# Gradle の存在確認
if (Test-Path "$DestDir\$DirName") {
    Write-Host "'$DestDir\$DirName' already exist."
} else {
    # ダウンロード
    Write-Host "download gradle."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZipPath

    # $home\app に展開
    Write-Host "Expand $TempZipPath to '$DestDir'."
    Expand-Archive -Path $TempZipPath -DestinationPath $DestDir
}

# Path の追加
$UserEnvPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
if (-Not $UserEnvPath.Contains($AdditionalPath)) {
    $UserEnvPath += ";$AdditionalPath"
    [Environment]::SetEnvironmentVariable('PATH', $UserEnvPath, 'User')
}


# 後片付け
if (Test-Path $TempZipPath) {
    Remove-Item $TempZipPath
}

