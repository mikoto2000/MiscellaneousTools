param(
    [Parameter(Mandatory=$true, HelpMessage="XML file.")]
    [string]$XmlFile,
    [Parameter(Mandatory=$true, HelpMessage="XPath string.")]
    [string]$XPath
)

# XML ドキュメント読み込み
$xml = [xml](Get-Content $XmlFile)

# XPath によるノード検索
$target_nodes = $xml.SelectNodes($XPath)

# マッチしたノードを走査しながらノード情報を出力
foreach ($current_node in $target_nodes) {
    if ($current_node.HasChildNodes) {
        # 子要素のあるノードの場合

        # マッチしたエレメント直下のエレメントを `タグ名:値` のカンマ区切りで列挙
        # 入れ子は値が空になるが、
        # XPath 文字列の確認をする程度であればこれで十分なはず
        $children_str = ($current_node.ChildNodes | % { [String]::Format("{0}: {1}", $_.name, $_.'#text') }) -join ", "

        # 取得したエレメントを出力
        Write-Host ([String]::Format("{0} : {{ {1} }}", $current_node.name, $children_str))
    } else {
        # 子要素のないノードの場合

        # 取得したノードの名前と値を出力
        Write-Host ([String]::Format("{0} : {{ {1} }}", $current_node.name, $current_node.value))
    }
}

