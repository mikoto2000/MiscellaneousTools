# 対象の書籍を取得
$targets = $(Get-ChildItem -Name "*.txt")

# 書籍ごとにディレクトリを作って関連ファイル(txt, mp3)を移動
foreach ($target in $targets)
{
    # 移動先ディレクトリ名取得
    $directoryName = [System.IO.Path]::GetFileNameWithoutExtension($target)
    New-Item -ItemType Directory $directoryName

    # txt, mp3 の移動
    $moveTarget = Get-ChildItem -File -Name "$directoryName*"
    Move-Item $moveTarget $directoryName
}

