# urlencode.ps1
#
# 引数で受け取った文字列を Base64 エンコードする。
#
# 引数 : Base64 エンコードしたい文字列
$text_byte = ([System.Text.Encoding]::Default).GetBytes($Args[0])
[Convert]::ToBase64String($text_byte)


