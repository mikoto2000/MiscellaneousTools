# クリップボードの複数行文字列を、 ` `(半角スペース) 区切りで join し、
# Google Translate で翻訳します。
#
# Usage:
#     powershell -sta -ExecutionPolicy RemoteSigned .\OpenGoogleTranslate.ps1
#
# ※ クリップボード空のテキスト取得は sta モードでしか動作しません
#    powershell を、 sta モードで起動してください。

Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName System.Web

$text = [Windows.Forms.Clipboard]::GetText()

$text = $text -replace "\r\n", " "
$text = $text -replace "\n", " "

$url = "https://translate.google.com/?sl=auto&hl=ja&tl=ja&text=" + [System.Web.HttpUtility]::UrlEncode($text) + "&op=translate"

Start-Process "$url"

