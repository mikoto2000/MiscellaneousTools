# 対象の書籍を取得
$targets = $(Get-ChildItem -Directory -Name)

# 書籍ごとに zip を作成
foreach ($target in $targets)
{
    7z a $target".zip" $target
}

