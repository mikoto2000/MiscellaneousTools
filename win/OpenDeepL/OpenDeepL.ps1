# �N���b�v�{�[�h�̕����s��������A ` `(���p�X�y�[�X) ��؂�� join ���A
# DeepL �Ŗ|�󂵂܂��B
#
# Usage:
#     powershell -sta -ExecutionPolicy RemoteSigned .\OpenDeepL.ps1
#
# �� �N���b�v�{�[�h��̃e�L�X�g�擾�� sta ���[�h�ł������삵�܂���
#    powershell ���A sta ���[�h�ŋN�����Ă��������B

Add-Type -Assembly System.Windows.Forms
Add-Type -AssemblyName System.Web

$text = [Windows.Forms.Clipboard]::GetText()

$text = $text -replace "\r\n", " "
$text = $text -replace "\n", " "

$url = "https://www.deepl.com/translator#auto/ja/" + [System.Web.HttpUtility]::UrlEncode($text)

$url = $url -replace "\+", " "
$url = $url -replace "%2f", "\%2f"

Start-Process "$url"

