# �Ώۂ̏��Ђ��擾
$targets = $(Get-ChildItem -Directory -Name)

# ���Ђ��Ƃ� zip ���쐬
foreach ($target in $targets)
{
    7z a $target".zip" $target
}

