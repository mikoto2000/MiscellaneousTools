# Split-Pdf.ps1
#
# PDF �𕪊����܂��B
# ������̃t�@�C������ '���̓t�@�C���̊g���q���O�������O_3���̐���' �ɂȂ�܂��B
# ������̃t�@�C���́A���� PDF �t�@�C���Ɠ����ꏊ�ɏo�͂���܂��B
#
# ����:
#     InputFile:   ���� PDF �t�@�C���p�X(�� �J�����g�f�B���N�g������̑��΃p�X�Ŏw�肷�邱��)
#     SplitNumber: ���� PDF �t�@�C�������������邩���w��(default: 1)
# ��������:
#     InputFile �̎w��� Windows �̐�΃p�X�w��ł͂��܂������܂���A
#     �J�����g�f�B���N�g������̑��΃p�X�� InputFile ���w�肵�Ă��������B
# ����v��:
#     - Docker for Windows ���C���X�g�[������Ă��邱��
#     - mikoto2000/pdftk �� pull �ς݂ł��邱��

Param(
    [string]$InputFile,
    [int]$SplitNumber = 1
)

# InputFile ���w�肳��Ă��Ȃ������ꍇ���I������
if ([String]::IsNullOrEmpty($InputFile)) {
    Write-Error "'InputFile' ���ݒ肳��Ă��܂���B 'InputFile' �ɕ����Ώۂ� PDF �t�@�C���p�X���w�肵�Ă��������B"
    return 1
}

# �Ώۃt�@�C�����i�[���Ă���f�B���N�g�����A docker �Ƀ}�E���g����f�B���N�g���Ƃ���
$target_dir = [System.IO.Path]::GetFullPath([System.IO.Path]::GetDirectoryName($InputFile))
$DOCKER_RUN='docker run -it --rm -e "LANG=C.UTF-8" -v "${target_dir}:/work" --workdir "/work" --net none mikoto2000/pdftk:latest'

# �t�@�C�����𔲂��o��
$out_file_base_name = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

# ���̓t�@�C���� docker �R�}���h�ɓn�����߂ɐ��`('./�t�@�C����.�g���q' �ɂ���)
$in_file_name = "./${out_file_base_name}" + [System.IO.Path]::GetExtension($InputFile)

# �y�[�W���擾
$page_number = Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name dump_data | grep NumberOfPages | cut -d' ' -f2")

# 1 �t�@�C�����Ƃ̃y�[�W�����v�Z
$page_number_of_file = [Math]::Truncate($page_number / $SplitNumber)
$page_number_of_file_one_more = $page_number_of_file + 1

# �]������炦��l�����̐�
$one_more_numbers = $page_number % $SplitNumber


# �]������炦�Ȃ��l�����̂��߂̃��[�v
$loop_num = $SplitNumber - $one_more_numbers
for ($i = 0; $i -lt $loop_num; $i++) {
    # �J�n�y�[�W�́u���[�v�� * 1 �y�[�W���Ƃ̃y�[�W�� + 1�v
    # (�J�n�y�[�W�� 1 �n�܂�Ȃ̂Ńv���X 1 ����)
    $start_page = $i * $page_number_of_file + 1

    #�I���y�[�W�́u(���[�v�� + 1) * 1 �y�[�W���Ƃ̃y�[�W���v
    $end_page = ($i + 1) * $page_number_of_file

    # �t�@�C���������ɕt���鐔�l�́u���[�v�񐔁v
    $file_number = ([string]${i}).PadLeft(3, "0")

    # �t�@�C�����g�ݗ���
    $out_file_name = "${out_file_base_name}_$file_number.pdf"

    # start_page ���� end_page �܂ł𔲂��o���� PDF ��
    Write-Host -NoNewline "Printing '$InputFile', ${start_page}-${end_page} to $out_file_name ..."
    Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name cat $start_page-$end_page output $out_file_name")
    Write-Host "done."
}


# �]������炦��l�����̂��߂̃��[�v
for ($i = 0; $i -lt $one_more_numbers; $i++) {
    # �I�t�Z�b�g�́u�]������炦�Ȃ��l�����̂��߂̃��[�v���v
    $offset = $loop_num * $page_number_of_file

    # �J�n�y�[�W�́u���[�v�� * 1 �y�[�W���Ƃ̃y�[�W�� + �x�[�X��(�]������炦�Ȃ��l�����̂��߂̃��[�v��) + 1�v
    # (�J�n�y�[�W�� 1 �n�܂�Ȃ̂Ńv���X 1 ����)
    # (1 �y�[�W���Ƃ̃y�[�W���́A�u�]������炦��l�����̂��߂̃��[�v�v�Ȃ̂Ńv���X 1 ����)
    $start_page = $i * $page_number_of_file_one_more + $offset + 1

    #�I���y�[�W�́u(���[�v�� + 1) * 1 �y�[�W���Ƃ̃y�[�W�� + �x�[�X��(�]������炦�Ȃ��l�����̂��߂̃��[�v��)�v
    # (1 �y�[�W���Ƃ̃y�[�W���́A�u�]������炦��l�����̂��߂̃��[�v�v�Ȃ̂Ńv���X 1 ����)
    $end_page = ($i + 1) * $page_number_of_file_one_more + $offset

    # �t�@�C���������ɕt���鐔�l�́u����̃��[�v�� + �]�肪���炦�Ȃ��l�����̃��[�v�񐔁v
    $file_number = ([string](${i} + ${loop_num})).PadLeft(3, "0")

    # �t�@�C�����g�ݗ���
    $out_file_name = "${out_file_base_name}_$file_number.pdf"

    # start_page ���� end_page �܂ł𔲂��o���� PDF ��
    Write-Host -NoNewline "Printing '$InputFile', ${start_page}-${end_page} to $out_file_name ..."
    Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name cat $start_page-$end_page output ${out_file_name}")
    Write-Host "done."
}

