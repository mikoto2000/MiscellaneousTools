# base64decode.ps1
#
# �����Ŏ󂯎����������� Base64 �f�R�[�h����B
#
# ���� : Base64 �f�R�[�h������������

$byte = [System.Convert]::FromBase64String($Args[0])
[System.Text.Encoding]::Default.GetString($byte)

