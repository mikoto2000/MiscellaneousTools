@echo off

rem base64decode.bat
rem
rem base64decode.ps1 ���g�p���āA�����Ŏ󂯎����������� Base64 �f�R�[�h����B
rem ����f�B���N�g���� `base64decode.ps1` ���i�[����Ă���K�v������B
rem
rem ���� : Base64 �f�R�[�h������������

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\base64decode.ps1 %*

