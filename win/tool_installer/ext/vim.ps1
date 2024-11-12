# vim.ps1
#
# vim �̃C���X�g�[�����s���܂��B
#
# �C���X�g�[������ Vim: https://github.com/vim/vim-win32-installer/releases
# �C���X�g�[����f�B���N�g��: `$home\app`


# �ŐV�o�[�W�����擾
$Owner="vim"
$Repo="vim-win32-installer"
$RepoPath="${Owner}/${Repo}"
$LatestVersionTag=$(Invoke-RestMethod "https://api.github.com/repos/${RepoPath}/releases/latest").tag_name
$LatestVersion=$LatestVersionTag.Remove(0, 1)

$VimDownloadUrl="https://github.com/${RepoPath}/releases/download/${LatestVersionTag}/gvim_${LatestVersion}_x64.zip"
$VimZipName=[System.IO.Path]::GetFileName($VimDownloadUrl)
#
$VimTempDir="$env:TEMP\vim_tmp"
$VimZipPath="$env:TEMP\$VimZipName"

$VimDirName="vim91"

$DestDir="$home\app"


# �o�͐�f�B���N�g���̊m�F�E����
if (-Not (Test-Path "$DestDir")) {
    Write-Host "create '$DestDir'."
    New-Item -ItemType Directory $DestDir
}

# vim �̑��݊m�F
# - vim �f�B���N�g�������݂��Ȃ���΁A�쐬���ēW�J
# - vim �f�B���N�g�������݂���Ȃ�΁A���ɑ��݂���f�B���N�g���� `vim �f�B���N�g��_bkup` �Ɉړ����āAvim �f�B���N�g���ɓW�J
# - `vim �f�B���N�g��_bkup` �����݂���ꍇ�A�폜
if (Test-Path "$DestDir\$VimDirName") {
    Write-Host "'$DestDir\$VimDirName' already exist."

    # vim �f�B���N�g���̑��݊m�F
    $VimDirPath = "$DestDir\${VimDirName}"
    $VimBkupDirPath = "${VimDirPath}_bkup"
    if (Test-Path "$VimDirPath") {
        # �o�b�N�A�b�v�f�B���N�g���̑��݊m�F
        # ���݂��Ă���΍폜
        if (Test-Path "$VimBkupDirPath") {
            Remove-Item -Recurse -Path "$VimBkupDirPath"
        }

        # ���łɂ��� vim �f�B���N�g�����o�b�N�A�b�v�f�B���N�g���ֈړ�
        Move-Item -Path "$VimDirPath" -Destination "$VimBkupDirPath"
    }
}

# �_�E�����[�h
Write-Host "download vim."
Invoke-WebRequest -Uri $VimDownloadUrl -OutFile $VimZipPath

# $home\app �ɓW�J
Write-Host "Expand $VimZipName to '$DestDir'."
Expand-Archive -Path $VimZipPath -DestinationPath $VimTempDir
Move-Item -Path $VimTempDir\vim\$VimDirName -Destination $DestDir\$VimDirName


# ��Еt��
if (Test-Path $VimZipPath) {
    Remove-Item $VimZipPath
}

if (Test-Path $VimTempDir) {
    Remove-Item -Recurse $VimTempDir
}


