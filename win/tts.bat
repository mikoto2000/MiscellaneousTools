
rem tts.bat
rem
rem VoiceroidController を使用して、引数で受け取ったテキストファイルを wav に変換する。
rem 変換後ファイル名は変換前ファイル名に「.wav」を追加したものになる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : UTF-8 で記述されたテキストファイルのリスト

for %%f in (%*) do (
    VoiceroidController --split-size 20000 -u -s -i "%%~ff" -o "%%~ff.wav"
)

pause
