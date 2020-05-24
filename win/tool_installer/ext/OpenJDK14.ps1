# Java14.ps1
#
# OpenJDK14 �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[������ JDK: https://jdk.java.net/14/
# �C���X�g�[����f�B���N�g��: `C:\Java\openjdk-14.0.1`

$Version="14.0.1"
$DirName="openjdk-$Version"
$ZipName="$DirName.zip"
$DownloadUrl="https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_windows-x64_bin.zip"

$TempZipPath="$env:TEMP\$ZipName"
$TempDirPath="$env:TEMP\jdk-$Version"

$DestDir="C:\Java"

$AdditionalPath="$DestDir\$DirName\bin"


# �o�͐�f�B���N�g���̊m�F�E����
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# OpenJDK14 �̑��݊m�F
if (Test-Path "$DestDir\$DirName") {
    Write-Host "'$DestDir\$DirName' already exist."
} else {
    # �_�E�����[�h
    Write-Host "download $DirName."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZipPath

    # C:\Java\openjdk-14.0.1 �ɓW�J
    Write-Host "Expand $TempZipPath to '$DestDir'."
    Expand-Archive -Path $TempZipPath -DestinationPath $env:TEMP
    Move-Item -Path $TempDirPath -Destination $DestDir\$DirName
}

# Path �̒ǉ�
$UserEnvPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
if (-Not $UserEnvPath.Contains($AdditionalPath)) {
    $UserEnvPath += ";$AdditionalPath"
    [Environment]::SetEnvironmentVariable('PATH', $UserEnvPath, 'User')
}


# ��Еt��
if (Test-Path $TempZipPath) {
    Remove-Item $TempZipPath
}

if (Test-Path $TempZipPath) {
    Remove-Item -Recurse $TempDirPath
}


