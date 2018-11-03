
rem tts_Yukari2.bat
rem
rem VoiceroidController2 を使用して、引数で受け取ったテキストファイルを wav に変換する。
rem 使用 VOICEROID は「結月ゆかり」。
rem 変換後ファイル名は変換前ファイル名の拡張子を「.wav」に変更したものになる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : UTF-8 で記述されたテキストファイルのリスト

for %%f in (%*) do (
    VoiceroidController2 --voiceroid "結月ゆかり - オーディオブック" --split-size 20000 --input-file "%%~ff" --output-file "%%~dpnf.wav"
)

