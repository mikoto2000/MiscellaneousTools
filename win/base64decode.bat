@echo off

rem base64decode.bat
rem
rem base64decode.ps1 を使用して、引数で受け取った文字列を Base64 デコードする。
rem 同一ディレクトリに `base64decode.ps1` が格納されている必要がある。
rem
rem 引数 : Base64 デコードしたい文字列

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\base64decode.ps1 %*

