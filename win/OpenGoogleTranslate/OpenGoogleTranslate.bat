@echo off
rem クリップボードの複数行文字列を、 ` `(半角スペース) 区切りで join し、
rem Google Translate で翻訳します。

powershell -sta -ExecutionPolicy RemoteSigned .\OpenGoogleTranslate.ps1

