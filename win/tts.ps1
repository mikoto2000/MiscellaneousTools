<#
.SYNOPSIS
�����Ŏw�肳�ꂽ�e�L�X�g��ǂݏグ�܂��B

.DESCRIPTION
SpeechSynthesizer ���g�p���āA�e�L�X�g��ǂݏグ�܂��B

.PARAMETER Text
�ǂݏグ��e�L�X�g�B

.PARAMETER SpeakerName
�ǂݏグ�b�Җ��B(�b�҈ꗗ�� ListSpeaker �I�v�V�����ŕ\���ł��܂�)

.PARAMETER Rate
�b�������B-10�`10 �̒l�B�f�t�H���g 0�B

.PARAMETER OutFile
�o�̓t�@�C�����B

.PARAMETER ListSpeaker
���̃I�v�V������t���Ď��s����ƁA�g�p�\�Șb�҂��ꗗ�\�����܂��B
#>
param(
    [Parameter(HelpMessage="�ǂݏグ�e�L�X�g")]
    [string]$Text,
    [Parameter(HelpMessage="�b�Җ�")]
    [string]$SpeakerName,
    [Parameter(HelpMessage="�b������(-10�`10)")]
    [string]$Rate = 0,
    [Parameter(HelpMessage="�����f�[�^�o�̓t�@�C����")]
    [string]$OutFile,
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

$speaker.Rate = $Rate

# �o�̓t�@�C�����w�肪����Ă���ꍇ�A speaker �ɐݒ�
if ($OutFile -ne '') {
    $speaker.SetOutputToWaveFile($OutFile)
}


# �b��
$speaker.Speak($Text)
$speaker.Dispose()

