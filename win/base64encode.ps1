# urlencode.ps1
#
# �����Ŏ󂯎����������� Base64 �G���R�[�h����B
#
# ���� : Base64 �G���R�[�h������������
$text_byte = ([System.Text.Encoding]::Default).GetBytes($Args[0])
[Convert]::ToBase64String($text_byte)


