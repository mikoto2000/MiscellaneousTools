<#
.SYNOPSIS
hosts ファイルを編集ます

.DESCRIPTION
※ 実行には `sed.exe` にパスを通しておく必要があります

.PARAMETER Domain
対象ドメイン

.PARAMETER Address
設定アドレス

.EXAMPLE
Hosts-Edit.ps1 -Domain example.com -Address 127.0.0.1

#>

param(
    [Parameter(Mandatory=$true, HelpMessage="target domain.")]
    [string]$Domain,
    [Parameter(Mandatory=$true, HelpMessage="ip address.")]
    [string]$Address,
    [Parameter(HelpMessage="hosts file path.")]
    [string]$HostsFilePath='C:\Windows\System32\drivers\etc\hosts'
)

# 対象ドメインの数を確認
$TargetCount = $(Get-Content $HostsFilePath | Select-String "\s$Domain`$").Length

if($TargetCount -eq 0) {
    # ひとつもなければ末尾に追加
    echo "$Address $Domain" >> $HostsFilePath
    exit 0
} elseif ($TargetCount -eq 1) {
    # ひとつだけ存在するならレコードを置換
    sed.exe -i -r -e "s/(.*)([ \f\n\r\t])$Domain`$/$Address`\2$Domain/" $HostsFilePath
    exit 0
} else {
    # レコードが複数あったら何もせず、終了コード 1 で終了
    Write-Error "対象のレコードが複数あります。 Domain: $Domain"
    exit 1
}

