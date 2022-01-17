# Gradle.ps1
#
# Gradle のインストールを行います。
#
# インストールする Gradle: https://gradle.org/releases/
# インストール先ディレクトリ: `$home\app`

# 最新バージョン取得
$Owner="gradle"
$Repo="gradle"
$RepoPath="${Owner}/${Repo}"
$LatestVersionTag=$(Invoke-RestMethod "https://api.github.com/repos/${RepoPath}/releases/latest").tag_name
$LatestVersion=$LatestVersionTag.Remove(0, 1)

$DirName="gradle-$LatestVersion"
$ZipName="$DirName.zip"
$DownloadUrl="https://services.gradle.org/distributions/gradle-${LatestVersion}-bin.zip"

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

