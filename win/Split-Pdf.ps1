# Split-Pdf.ps1
#
# PDF を分割します。
# 分割後のファイル名は '入力ファイルの拡張子を外した名前_3桁の数字' になります。
# 分割後のファイルは、入力 PDF ファイルと同じ場所に出力されます。
#
# 引数:
#     InputFile:   入力 PDF ファイルパス(※ カレントディレクトリからの相対パスで指定すること)
#     SplitNumber: 入力 PDF ファイルを何分割するかを指定(default: 1)
# 制限事項:
#     InputFile の指定は Windows の絶対パス指定ではうまくいきません、
#     カレントディレクトリからの相対パスで InputFile を指定してください。
# 動作要件:
#     - Docker for Windows がインストールされていること
#     - mikoto2000/pdftk が pull 済みであること

Param(
    [string]$InputFile,
    [int]$SplitNumber = 1
)

# InputFile が指定されていなかった場合即終了する
if ([String]::IsNullOrEmpty($InputFile)) {
    Write-Error "'InputFile' が設定されていません。 'InputFile' に分割対象の PDF ファイルパスを指定してください。"
    return 1
}

# 対象ファイルを格納しているディレクトリを、 docker にマウントするディレクトリとする
$target_dir = [System.IO.Path]::GetFullPath([System.IO.Path]::GetDirectoryName($InputFile))
$DOCKER_RUN='docker run -it --rm -e "LANG=C.UTF-8" -v "${target_dir}:/work" --workdir "/work" --net none mikoto2000/pdftk:latest'

# ファイル名を抜き出す
$out_file_base_name = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

# 入力ファイルを docker コマンドに渡すために成形('./ファイル名.拡張子' にする)
$in_file_name = "./${out_file_base_name}" + [System.IO.Path]::GetExtension($InputFile)

# ページ数取得
$page_number = Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name dump_data | grep NumberOfPages | cut -d' ' -f2")

# 1 ファイルごとのページ数を計算
$page_number_of_file = [Math]::Truncate($page_number / $SplitNumber)
$page_number_of_file_one_more = $page_number_of_file + 1

# 余りをもらえる人たちの数
$one_more_numbers = $page_number % $SplitNumber


# 余りをもらえない人たちのためのループ
$loop_num = $SplitNumber - $one_more_numbers
for ($i = 0; $i -lt $loop_num; $i++) {
    # 開始ページは「ループ回数 * 1 ページごとのページ数 + 1」
    # (開始ページは 1 始まりなのでプラス 1 する)
    $start_page = $i * $page_number_of_file + 1

    #終了ページは「(ループ回数 + 1) * 1 ページごとのページ数」
    $end_page = ($i + 1) * $page_number_of_file

    # ファイル名末尾に付ける数値は「ループ回数」
    $file_number = ([string]${i}).PadLeft(3, "0")

    # ファイル名組み立て
    $out_file_name = "${out_file_base_name}_$file_number.pdf"

    # start_page から end_page までを抜き出して PDF 化
    Write-Host -NoNewline "Printing '$InputFile', ${start_page}-${end_page} to $out_file_name ..."
    Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name cat $start_page-$end_page output $out_file_name")
    Write-Host "done."
}


# 余りをもらえる人たちのためのループ
for ($i = 0; $i -lt $one_more_numbers; $i++) {
    # オフセットは「余りをもらえない人たちのためのループ数」
    $offset = $loop_num * $page_number_of_file

    # 開始ページは「ループ回数 * 1 ページごとのページ数 + ベース回数(余りをもらえない人たちのためのループ数) + 1」
    # (開始ページは 1 始まりなのでプラス 1 する)
    # (1 ページごとのページ数は、「余りをもらえる人たちのためのループ」なのでプラス 1 する)
    $start_page = $i * $page_number_of_file_one_more + $offset + 1

    #終了ページは「(ループ回数 + 1) * 1 ページごとのページ数 + ベース回数(余りをもらえない人たちのためのループ数)」
    # (1 ページごとのページ数は、「余りをもらえる人たちのためのループ」なのでプラス 1 する)
    $end_page = ($i + 1) * $page_number_of_file_one_more + $offset

    # ファイル名末尾に付ける数値は「今回のループ回数 + 余りがもらえない人たちのループ回数」
    $file_number = ([string](${i} + ${loop_num})).PadLeft(3, "0")

    # ファイル名組み立て
    $out_file_name = "${out_file_base_name}_$file_number.pdf"

    # start_page から end_page までを抜き出して PDF 化
    Write-Host -NoNewline "Printing '$InputFile', ${start_page}-${end_page} to $out_file_name ..."
    Invoke-Expression ("$DOCKER_RUN pdftk $in_file_name cat $start_page-$end_page output ${out_file_name}")
    Write-Host "done."
}

