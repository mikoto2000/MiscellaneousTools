@echo off
rem クリップボードの複数行文字列を、 ` `(半角スペース) 区切りで join し、
rem DeepL で翻訳します。

set THIS_DIR=%~dp0
powershell -sta -ExecutionPolicy RemoteSigned %THIS_DIR%\OpenDeepL.ps1

