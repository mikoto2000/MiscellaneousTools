@echo off
rem �N���b�v�{�[�h�̕����s��������A ` `(���p�X�y�[�X) ��؂�� join ���A
rem DeepL �Ŗ|�󂵂܂��B

set THIS_DIR=%~dp0
powershell -sta -ExecutionPolicy RemoteSigned %THIS_DIR%\OpenDeepL.ps1

