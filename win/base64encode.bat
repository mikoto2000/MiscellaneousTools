@echo off

rem base64encode.bat
rem
rem base64encode.ps1 を使用して、引数で受け取った文字列を Base64 エンコードする。
rem 同一ディレクトリに `base64encode.ps1` が格納されている必要がある。
rem
rem 引数 : Base64 エンコードしたい文字列

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\base64encode.ps1 %*


