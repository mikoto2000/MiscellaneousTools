@echo off
rem �N���b�v�{�[�h�̕����s��������A ` `(���p�X�y�[�X) ��؂�� join ���A
rem Google Translate �Ŗ|�󂵂܂��B

set THIS_DIR=%~dp0
powershell -sta -ExecutionPolicy RemoteSigned %THIS_DIR%\OpenGoogleTranslate.ps1

