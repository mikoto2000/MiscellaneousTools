<#
.SYNOPSIS
XML �t�@�C������ XPath ������Ƀ}�b�`�����v�f�𒊏o���܂��B

.PARAMETER XmlFile
XML �t�@�C��

.PARAMETER XPath
���o�Ώۂ����� XPath ������

.PARAMETER Namespaces
XPath �Ō�������ۂɎg�p���� Namespace ���w��

.EXAMPLE
xpath.ps1 -XmlFile target_file.xml -XPath //user

.EXAMPLE
xpath.ps1 -XmlFile target_file.xml -XPath //ns1:user -Namespaces @{prefix="ns1";uri="http://namespace1.example.com"},@{prefix="ns2";uri="http://namespace2.example.com"}

#>

param(
    [Parameter(Mandatory=$true, HelpMessage="XML file.")]
    [string]$XmlFile,
    [Parameter(Mandatory=$true, HelpMessage="XPath string.")]
    [string]$XPath,
    [Array]$Namespaces
)

# XML �h�L�������g�ǂݍ���
$xml = [xml](Get-Content -Encoding UTF8 $XmlFile)
$ns_manager = [System.Xml.XmlNamespaceManager]::new($xml.NameTable)

# �w�肳�ꂽ Namespace �� prefix �� uri �� mn_manager �ɒǉ�
if ($Namespaces -ne $Null) {
    foreach ($Namespace in $Namespaces) {
        $ns_manager.AddNamespace($Namespace['prefix'], $Namespace['uri'])
    }
}

# XPath �ɂ��m�[�h����
$target_nodes = $xml.SelectNodes($XPath, $ns_manager)

# �}�b�`�����m�[�h�𑖍����Ȃ���m�[�h�����o��
foreach ($current_node in $target_nodes) {
    if ($current_node.HasChildNodes) {
        # �q�v�f�̂���m�[�h�̏ꍇ

        # �}�b�`�����G�������g�����̃G�������g�� `�^�O��:�l` �̃J���}��؂�ŗ�
        # ����q�͒l����ɂȂ邪�A
        # XPath ������̊m�F��������x�ł���΂���ŏ\���Ȃ͂�
        $children_str = ($current_node.ChildNodes | % { [String]::Format("{0}: {1}", $_.name, $_.'#text') }) -join ", "

        # �擾�����G�������g���o��
        Write-Host ([String]::Format("{0} : {{ {1} }}", $current_node.name, $children_str))
    } else {
        # �q�v�f�̂Ȃ��m�[�h�̏ꍇ

        # �擾�����m�[�h�̖��O�ƒl���o��
        Write-Host ([String]::Format("{0} : {{ {1} }}", $current_node.name, $current_node.value))
    }
}

