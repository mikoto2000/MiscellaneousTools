@echo off

rem urlencode.bat
rem
rem urlencode.ps1 を使用して、引数で受け取った文字列を URL エンコードする。
rem 同一ディレクトリに `urlencode.ps1` が格納されている必要がある。
rem
rem 引数 : URL エンコードしたい文字列

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\urlencode.ps1 %*

