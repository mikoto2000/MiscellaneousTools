# Java14.ps1
#
# OpenJDK14 のインストールを行います。
#
# インストールする JDK: https://jdk.java.net/14/
# インストール先ディレクトリ: `C:\Java\openjdk-14.0.1`

$Version="14.0.1"
$DirName="openjdk-$Version"
$ZipName="$DirName.zip"
$DownloadUrl="https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_windows-x64_bin.zip"

$TempZipPath="$env:TEMP\$ZipName"
$TempDirPath="$env:TEMP\jdk-$Version"

$DestDir="C:\Java"

$AdditionalPath="$DestDir\$DirName\bin"


# 出力先ディレクトリの確認・生成
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# OpenJDK14 の存在確認
if (Test-Path "$DestDir\$DirName") {
    Write-Host "'$DestDir\$DirName' already exist."
} else {
    # ダウンロード
    Write-Host "download $DirName."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZipPath

    # C:\Java\openjdk-14.0.1 に展開
    Write-Host "Expand $TempZipPath to '$DestDir'."
    Expand-Archive -Path $TempZipPath -DestinationPath $env:TEMP
    Move-Item -Path $TempDirPath -Destination $DestDir\$DirName
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

if (Test-Path $TempZipPath) {
    Remove-Item -Recurse $TempDirPath
}


