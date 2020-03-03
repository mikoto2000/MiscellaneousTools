<#
.SYNOPSIS
�����Ŏw�肳�ꂽ�e�L�X�g��ǂݏグ�܂��B

.DESCRIPTION
SpeechSynthesizer ���g�p���āA�e�L�X�g��ǂݏグ�܂��B

.PARAMETER Text
�ǂݏグ��e�L�X�g�B

.PARAMETER SpeakerName
�ǂݏグ�b�Җ��B(�b�҈ꗗ�� ListSpeaker �I�v�V�����ŕ\���ł��܂�)

.PARAMETER ListSpeaker
���̃I�v�V������t���Ď��s����ƁA�g�p�\�Șb�҂��ꗗ�\�����܂��B
#>
param(
    [Parameter(HelpMessage="�ǂݏグ�e�L�X�g")]
    [string]$Text,
    [Parameter(HelpMessage="�b�Җ�")]
    [string]$SpeakerName,
    [Parameter(HelpMessage="�b�҈ꗗ�\��")]
    [switch]$ListSpeaker
)

Add-Type -AssemblyName System.speech
$speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer

# �X�s�[�J�[�ꗗ�\��
if ($ListSpeaker) {
    $speaker.GetInstalledVoices() | % { $_.VoiceInfo.Name }
    exit
}

# �X�s�[�J�[���w�肪����Ă���ꍇ�� speaker �ɐݒ�
if ($SpeakerName -ne '') {
    $speaker.SelectVoice($SpeakerName)
}

# �b��
$speaker.Speak($Text)

