
rem concatMp3.bat
rem
rem ffmpeg ���g�p���āA�����Ŏ󂯎�����t�@�C���� concat ���Ĉ�� mp3 �ɕϊ�����B
rem �ϊ���t�@�C�����́uconcated.mp3�v�ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : ffmpeg �ŕϊ��\�ȉ����t�@�C���̃��X�g

setlocal enabledelayedexpansion

rem �����̐��𐔂���
set ARGC=0
for %%a in ( %* ) do (
    set /a ARGC+=1
)

rem �������p�C�v��؂�� JOIN ����
set ARGS=%1
shift /1
:loop
    set ARGS=!ARGS!^^^|%1
    shift /1
    if "" NEQ %1 goto loop

rem mp3 �����R�}���h���s
ffmpeg -i concat:"!ARGS!" -acodec copy concated.mp3

pause
