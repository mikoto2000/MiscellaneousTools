# �N���b�v�{�[�h�̕����s��������A ` `(���p�X�y�[�X) ��؂�� join ���A
# Google Translate �Ŗ|�󂵂܂��B
#
# Usage:
#     powershell -sta -ExecutionPolicy RemoteSigned .\OpenGoogleTranslate.ps1
#
# �� �N���b�v�{�[�h��̃e�L�X�g�擾�� sta ���[�h�ł������삵�܂���
#    powershell ���A sta ���[�h�ŋN�����Ă��������B

Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName System.Web

$text = [Windows.Forms.Clipboard]::GetText()

$text = $text -replace "\r\n", " "
$text = $text -replace "\n", " "

$url = "https://translate.google.com/?sl=auto&hl=ja&tl=ja&text=" + [System.Web.HttpUtility]::UrlEncode($text) + "&op=translate"

Start-Process "$url"

