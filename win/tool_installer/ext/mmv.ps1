# mmv.ps1
#
# mmv のインストールを行います。
#
# インストールするもの: https://github.com/itchyny/mmv/releases
# インストール先ディレクトリ: `$home\bin`


# 最新バージョン取得
$Owner="itchyny"
$Repo="mmv"
$RepoPath="${Owner}/${Repo}"
$LatestVersionTag=$(Invoke-RestMethod "https://api.github.com/repos/${RepoPath}/releases/latest").tag_name
$LatestVersion=$LatestVersionTag.Remove(0, 1)

$MmvDownloadUrl="https://github.com/${RepoPath}/releases/download/${LatestVersionTag}/mmv_v${LatestVersion}_windows_amd64.zip"
$MmvZipName=[System.IO.Path]::GetFileName($MmvDownloadUrl)
#
$MmvTempDir="$env:TEMP\mmv_tmp"
$MmvZipPath="$env:TEMP\$MmvZipName"

$MmvDirName="mmv_v${LatestVersion}_windows_amd64"

$DestDir="$home\bin"


# ダウンロード
Write-Host "download mmv."
Invoke-WebRequest -Uri $MmvDownloadUrl -OutFile $MmvZipPath

# $home\bin に展開
Write-Host "Expand $MmvZipName to '$DestDir'."
Expand-Archive -Path $MmvZipPath -DestinationPath $MmvTempDir
Move-Item -force -Path $MmvTempDir\$MmvDirName\mmv.exe -Destination $DestDir

# 後片付け
if (Test-Path $MmvZipPath) {
    Remove-Item $MmvZipPath
}

if (Test-Path $MmvTempDir) {
    Remove-Item -Recurse $MmvTempDir
}

