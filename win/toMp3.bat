@echo off

rem toMp3.bat
rem
rem ffmpeg を使用して、引数で受け取ったファイルを mp3 に変換する。
rem 変換後ファイル名は変換前ファイル名の拡張子を「.mp3」に変更したものになる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : ffmpeg で変換可能な音声ファイルのリスト

for %%f in (%*) do (
    start cmd /c ffmpeg -i %%f %%~dpnf.mp3
)

