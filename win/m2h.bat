@echo off

rem m2h.bat
rem
rem pandoc を使用して、引数で受け取ったマークダウン形式テキストファイルを html に変換する。
rem 変換後ファイル名は変換前ファイル名の拡張子を「.html」に変更したものになる。
rem 変換後ファイルは変換前ファイルと同じディレクトリに作成される。
rem
rem 引数 : pandoc で変換可能な UTF-8 テキストファイルのリスト

set THIS_DIR=%~dp0

for %%t in (%*) do (
    start cmd /c pandoc -f markdown+pandoc_title_block-ascii_identifiers -t html5 --standalone --self-contained --data-dir=%%~dpt --toc --css %THIS_DIR%\default.css %%t -o "%%~dpnt.html"
)

