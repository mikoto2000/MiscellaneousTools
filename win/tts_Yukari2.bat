
rem tts_Yukari2.bat
rem
rem VoiceroidController2 ���g�p���āA�����Ŏ󂯎�����e�L�X�g�t�@�C���� wav �ɕϊ�����B
rem �g�p VOICEROID �́u�����䂩��v�B
rem �ϊ���t�@�C�����͕ϊ��O�t�@�C�����̊g���q���u.wav�v�ɕύX�������̂ɂȂ�B
rem �ϊ���t�@�C���͕ϊ��O�t�@�C���Ɠ����f�B���N�g���ɍ쐬�����B
rem
rem ���� : UTF-8 �ŋL�q���ꂽ�e�L�X�g�t�@�C���̃��X�g

for %%f in (%*) do (
    VoiceroidController2 --voiceroid "�����䂩�� - �I�[�f�B�I�u�b�N" --split-size 20000 --input-file "%%~ff" --output-file "%%~dpnf.wav"
)

