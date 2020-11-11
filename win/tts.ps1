<#
.SYNOPSIS
引数で指定されたテキストを読み上げます。

.DESCRIPTION
SpeechSynthesizer を使用して、テキストを読み上げます。

.PARAMETER Text
読み上げるテキスト。

.PARAMETER SpeakerName
読み上げ話者名。(話者一覧は ListSpeaker オプションで表示できます)

.PARAMETER Rate
話す速さ。-10～10 の値。デフォルト 0。

.PARAMETER OutFile
出力ファイル名。

.PARAMETER ListSpeaker
このオプションを付けて実行すると、使用可能な話者を一覧表示します。
#>
param(
    [Parameter(HelpMessage="読み上げテキスト")]
    [string]$Text,
    [Parameter(HelpMessage="話者名")]
    [string]$SpeakerName,
    [Parameter(HelpMessage="話す速さ(-10～10)")]
    [string]$Rate = 0,
    [Parameter(HelpMessage="音声データ出力ファイル名")]
    [string]$OutFile,
    [Parameter(HelpMessage="話者一覧表示")]
    [switch]$ListSpeaker
)

Add-Type -AssemblyName System.speech
$speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer

# スピーカー一覧表示
if ($ListSpeaker) {
    $speaker.GetInstalledVoices() | % { $_.VoiceInfo.Name }
    exit
}

# スピーカー名指定がされている場合は speaker に設定
if ($SpeakerName -ne '') {
    $speaker.SelectVoice($SpeakerName)
}

$speaker.Rate = $Rate

# 出力ファイル名指定がされている場合、 speaker に設定
if ($OutFile -ne '') {
    $speaker.SetOutputToWaveFile($OutFile)
}


# 話す
$speaker.Speak($Text)
$speaker.Dispose()

