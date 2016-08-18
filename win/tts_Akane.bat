
rem tts_Akane.bat
rem
rem VoiceroidController を使用して、引数で受け取ったテキストファイルを wav に変換する。
rem 使用 VOICEROID は「琴葉茜」。
rem 変換後ファイル名は変換前ファイル名の拡張子を「.wav」に変更したものになる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : UTF-8 で記述されたテキストファイルのリスト

for %%f in (%*) do (
    VoiceroidController --voiceroid Akane --split-size 20000 -u -s -i "%%~ff" -o "%%~dpnf.wav"
)

pause
