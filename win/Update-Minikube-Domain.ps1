<#
.SYNOPSIS
指定したドメインを、ローカルで実行中の Minikube へ向けます。

.DESCRIPTION
※ 実行には `Edit-Hosts.ps1` にパスを通しておく必要があります

.PARAMETER Domain
対象ドメイン

.EXAMPLE
Update-Minikube-Domain.ps1 -Domain example.com

#>

param(
    [Parameter(Mandatory=$true, HelpMessage="target domain.")]
    [string]$Domain
)

# Minikube の IP 取得
$MinikubeIp = $(minikube ip)

Edit-Hosts.ps1 -Domain $Domain -Address $MinikubeIp

