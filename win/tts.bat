
rem tts.bat
rem
rem VoiceroidController ���g�p���āA�����Ŏ󂯎�����e�L�X�g�t�@�C���� wav �ɕϊ�����B
rem �ϊ���t�@�C�����͕ϊ��O�t�@�C�����Ɂu.wav�v��ǉ��������̂ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : UTF-8 �ŋL�q���ꂽ�e�L�X�g�t�@�C���̃��X�g

for %%f in (%*) do (
    VoiceroidController --split-size 20000 -u -s -i "%%~ff" -o "%%~ff.wav"
)

pause
