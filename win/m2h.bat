@echo off

rem m2h.bat
rem
rem pandoc ���g�p���āA�����Ŏ󂯎�����}�[�N�_�E���`���e�L�X�g�t�@�C���� html �ɕϊ�����B
rem �ϊ���t�@�C�����͕ϊ��O�t�@�C�����̊g���q���u.html�v�ɕύX�������̂ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : pandoc �ŕϊ��\�� UTF-8 �e�L�X�g�t�@�C���̃��X�g

set THIS_DIR=%~dp0

for %%t in (%*) do (
    start cmd /c pandoc -f markdown+pandoc_title_block-ascii_identifiers -t html5 --standalone --self-contained --data-dir=%%~dpt --toc --css %THIS_DIR%\default.css %%t -o "%%~dpnt.html"
)

