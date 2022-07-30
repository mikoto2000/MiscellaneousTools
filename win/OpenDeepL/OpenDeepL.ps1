# クリップボードの複数行文字列を、 ` `(半角スペース) 区切りで join し、
# DeepL で翻訳します。
#
# Usage:
#     powershell -sta -ExecutionPolicy RemoteSigned .\OpenDeepL.ps1
#
# ※ クリップボード空のテキスト取得は sta モードでしか動作しません
#    powershell を、 sta モードで起動してください。

Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName System.Web

$text = [Windows.Forms.Clipboard]::GetText()

$text = $text -replace "\r\n", " "
$text = $text -replace "\n", " "

$url = "https://www.deepl.com/translator#auto/ja/" + [System.Web.HttpUtility]::UrlEncode($text)

$url = $url -replace "\+", " "
$url = $url -replace "%2f", "\%2f"

Start-Process "$url"

