# ColorTool.ps1
#
# ColorTool �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[����f�B���N�g��: `$home\bin`
#
$ColorToolTempFile="$env:TEMP\ColorTool.zip"
$BinDir="$home\bin"

# �o�͐�f�B���N�g���̊m�F�E����
$DestDir=$BinDir
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# ColorTool.exe �̑��݊m�F
if (Test-Path "$DestDir\ColorTool.exe") {
    Write-Host "'$DestDir\ColorTool.exe' already exist."
} else {
    # �_�E�����[�h
    Write-Host "download ColorTool.zip."
    Invoke-WebRequest -Uri https://github.com/Microsoft/console/releases/download/1810.02002/ColorTool.zip -OutFile $ColorToolTempFile

    # $home\bin �ɓW�J
    Write-Host "Expand ColorTool.zip to '$DestDir'."
    Expand-Archive -Path $ColorToolTempFile -DestinationPath $DestDir
}


# �F�ݒ肪�v���t�@�C���ɑ��݂��Ă��Ȃ���ΐݒ��ǉ�
$ColorToolCommand = "ColorTool.exe -q OneHalfDark"
if (-Not (Get-Content $profile | Select-String -Quiet $ColorToolCommand)) {
    Write-Output "$ColorToolCommand" | Out-File -Append -Encoding "UTF8" -FilePath $($profile)
}

# ��Еt��
if (Test-Path $ColorToolTempFile) {
    Remove-Item $ColorToolTempFile
}


