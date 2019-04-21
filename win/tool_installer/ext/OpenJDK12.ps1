# Java12.ps1
#
# OpenJDK12 �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[������ JDK: https://jdk.java.net/12/
# �C���X�g�[����f�B���N�g��: `C:\Java\openjdk-12.0.1`

$Version="12.0.1"
$DirName="openjdk-$Version"
$ZipName="$DirName.zip"
$DownloadUrl="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_windows-x64_bin.zip"

$TempZipPath="$env:TEMP\$ZipName"
$TempDirPath="$env:TEMP\jdk-$Version"

$DestDir="C:\Java"

$AdditionalPath="$DestDir\$DirName\bin"


# �o�͐�f�B���N�g���̊m�F�E����
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# OpenJDK12 �̑��݊m�F
if (Test-Path "$DestDir\$DirName") {
    Write-Host "'$DestDir\$DirName' already exist."
} else {
    # �_�E�����[�h
    Write-Host "download openjdk-12.0.1."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZipPath

    # C:\Java\openjdk-12.0.1 �ɓW�J
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



