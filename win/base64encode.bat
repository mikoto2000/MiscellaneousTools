@echo off

rem base64encode.bat
rem
rem base64encode.ps1 ���g�p���āA�����Ŏ󂯎����������� Base64 �G���R�[�h����B
rem ����f�B���N�g���� `base64encode.ps1` ���i�[����Ă���K�v������B
rem
rem ���� : Base64 �G���R�[�h������������

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\base64encode.ps1 %*


