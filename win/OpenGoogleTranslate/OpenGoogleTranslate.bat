@echo off
rem クリップボードの複数行文字列を、 ` `(半角スペース) 区切りで join し、
rem Google Translate で翻訳します。

set THIS_DIR=%~dp0
powershell -sta -ExecutionPolicy RemoteSigned %THIS_DIR%\OpenGoogleTranslate.ps1

