@echo off

rem toMp3.bat
rem
rem ffmpeg ���g�p���āA�����Ŏ󂯎�����t�@�C���� mp3 �ɕϊ�����B
rem �ϊ���t�@�C�����͕ϊ��O�t�@�C�����̊g���q���u.mp3�v�ɕύX�������̂ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : ffmpeg �ŕϊ��\�ȉ����t�@�C���̃��X�g

for %%f in (%*) do (
    start cmd /c ffmpeg -i %%f %%~dpnf.mp3
)

