@echo off

rem urlencode.bat
rem
rem urlencode.ps1 ���g�p���āA�����Ŏ󂯎����������� URL �G���R�[�h����B
rem ����f�B���N�g���� `urlencode.ps1` ���i�[����Ă���K�v������B
rem
rem ���� : URL �G���R�[�h������������

set THIS_DIR=%~dp0

powershell -ExecutionPolicy RemoteSigned %THIS_DIR%\urlencode.ps1 %*

