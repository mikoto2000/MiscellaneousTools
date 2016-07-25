
rem concatMp3.bat
rem
rem ffmpeg を使用して、引数で受け取ったファイルを concat して一つの mp3 に変換する。
rem 変換後ファイル名は「concated.mp3」になる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : ffmpeg で変換可能な音声ファイルのリスト

setlocal enabledelayedexpansion

rem 引数の数を数える
set ARGC=0
for %%a in ( %* ) do (
    set /a ARGC+=1
)

rem 引数をパイプ区切りで JOIN する
set ARGS=%1
shift /1
:loop
    set ARGS=!ARGS!^^^|%1
    shift /1
    if "" NEQ %1 goto loop

rem mp3 結合コマンド発行
ffmpeg -i concat:"!ARGS!" -acodec copy concated.mp3

pause
