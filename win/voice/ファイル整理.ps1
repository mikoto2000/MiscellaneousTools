# �Ώۂ̏��Ђ��擾
$targets = $(Get-ChildItem -Name "*.txt")

# ���Ђ��ƂɃf�B���N�g��������Ċ֘A�t�@�C��(txt, mp3)���ړ�
foreach ($target in $targets)
{
    # �ړ���f�B���N�g�����擾
    $directoryName = [System.IO.Path]::GetFileNameWithoutExtension($target)
    New-Item -ItemType Directory $directoryName

    # txt, mp3 �̈ړ�
    $moveTarget = Get-ChildItem -File -Name "$directoryName*"
    Move-Item $moveTarget $directoryName
}

