# ‘ÎÛ‚Ì‘Ğ‚ğæ“¾
$targets = $(Get-ChildItem -Directory -Name)

# ‘Ğ‚²‚Æ‚É zip ‚ğì¬
foreach ($target in $targets)
{
    7z a $target".zip" $target
}

