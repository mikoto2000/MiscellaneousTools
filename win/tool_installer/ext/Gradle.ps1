# Gradle.ps1
#
# Gradle �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[������ Gradle: https://gradle.org/releases/
# �C���X�g�[����f�B���N�g��: `$home\app`

$Version="6.4.1"
$DirName="gradle-$Version"
$ZipName="$DirName.zip"
$DownloadUrl="https://services.gradle.org/distributions/gradle-6.4.1-bin.zip"

$TempZipPath="$env:TEMP\$ZipName"

$DestDir="$home\app"

$AdditionalPath="$DestDir\$DirName\bin"


# �o�͐�f�B���N�g���̊m�F�E����
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# Gradle �̑��݊m�F
if (Test-Path "$DestDir\$DirName") {
    Write-Host "'$DestDir\$DirName' already exist."
} else {
    # �_�E�����[�h
    Write-Host "download gradle."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZipPath

    # $home\app �ɓW�J
    Write-Host "Expand $TempZipPath to '$DestDir'."
    Expand-Archive -Path $TempZipPath -DestinationPath $DestDir
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

