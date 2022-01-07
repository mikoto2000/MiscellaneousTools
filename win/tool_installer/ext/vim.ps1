# vim.ps1
#
# vim �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[������ Vim: https://github.com/vim/vim-win32-installer/releases
# �C���X�g�[����f�B���N�g��: `$home\app`

$VimDownloadUrl="https://github.com/vim/vim-win32-installer/releases/download/v8.2.4023/gvim_8.2.4023_x64.zip"
$VimZipName=[System.IO.Path]::GetFileName($VimDownloadUrl)
#
$VimTempDir="$env:TEMP\vim_tmp"
$VimZipPath="$env:TEMP\$VimZipName"

$VimDirName="vim82"

$DestDir="$home\app"


# �o�͐�f�B���N�g���̊m�F�E����
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# vim �̑��݊m�F
if (Test-Path "$DestDir\$VimDirName") {
    Write-Host "'$DestDir\$VimDirName' already exist."
} else {
    # �_�E�����[�h
    Write-Host "download vim."
    Invoke-WebRequest -Uri $VimDownloadUrl -OutFile $VimZipPath

    # $home\app �ɓW�J
    Write-Host "Expand $VimZipName to '$DestDir'."
    Expand-Archive -Path $VimZipPath -DestinationPath $VimTempDir
    Move-Item -Path $VimTempDir\vim\$VimDirName -Destination $DestDir\$VimDirName
}


# ��Еt��
if (Test-Path $VimZipPath) {
    Remove-Item $VimZipPath
}

if (Test-Path $VimTempDir) {
    Remove-Item -Recurse $VimTempDir
}


