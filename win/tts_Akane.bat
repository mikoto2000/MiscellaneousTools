
rem tts_Akane.bat
rem
rem VoiceroidController ���g�p���āA�����Ŏ󂯎�����e�L�X�g�t�@�C���� wav �ɕϊ�����B
rem �g�p VOICEROID �́u�՗t���v�B
rem �ϊ���t�@�C�����͕ϊ��O�t�@�C�����̊g���q���u.wav�v�ɕύX�������̂ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : UTF-8 �ŋL�q���ꂽ�e�L�X�g�t�@�C���̃��X�g

for %%f in (%*) do (
    VoiceroidController --voiceroid Akane --split-size 20000 -u -s -i "%%~ff" -o "%%~dpnf.wav"
)

pause
