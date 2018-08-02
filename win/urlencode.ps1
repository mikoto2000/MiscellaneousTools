# urlencode.ps1
#
# 引数で受け取った文字列を URL エンコードする。
#
# 引数 : URL エンコードしたい文字列

Add-Type -AssemblyName System.Web
[System.Web.HttpUtility]::UrlEncode($Args[0])

