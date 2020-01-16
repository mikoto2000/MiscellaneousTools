<#
.SYNOPSIS
XML ファイルから XPath 文字列にマッチした要素を抽出します。

.PARAMETER XmlFile
XML ファイル

.PARAMETER XPath
抽出対象を現す XPath 文字列

.PARAMETER Namespaces
XPath で検索する際に使用する Namespace を指定

.EXAMPLE
xpath.ps1 -XmlFile target_file.xml -XPath //user

.EXAMPLE
xpath.ps1 -XmlFile target_file.xml -XPath //ns1:user -Namespaces @{prefix="ns1";uri="http://namespace1.example.com"},@{prefix="ns2";uri="http://namespace2.example.com"}

#>

param(
    [Parameter(Mandatory=$true, HelpMessage="XML file.")]
    [string]$XmlFile,
    [Parameter(Mandatory=$true, HelpMessage="XPath string.")]
    [string]$XPath,
    [Array]$Namespaces
)

# XML ドキュメント読み込み
$xml = [xml](Get-Content -Encoding UTF8 $XmlFile)
$ns_manager = [System.Xml.XmlNamespaceManager]::new($xml.NameTable)

# 指定された Namespace の prefix と uri を mn_manager に追加
if ($Namespaces -ne $Null) {
    foreach ($Namespace in $Namespaces) {
        $ns_manager.AddNamespace($Namespace['prefix'], $Namespace['uri'])
    }
}

# XPath によるノード検索
$target_nodes = $xml.SelectNodes($XPath, $ns_manager)

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

