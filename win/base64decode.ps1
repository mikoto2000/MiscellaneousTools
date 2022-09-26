# base64decode.ps1
#
# 引数で受け取った文字列を Base64 デコードする。
#
# 引数 : Base64 デコードしたい文字列

$byte = [System.Convert]::FromBase64String($Args[0])
[System.Text.Encoding]::Default.GetString($byte)

