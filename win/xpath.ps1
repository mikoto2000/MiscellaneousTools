param(
    [Parameter(Mandatory=$true, HelpMessage="XML file.")]
    [string]$XmlFile,
    [Parameter(Mandatory=$true, HelpMessage="XPath string.")]
    [string]$XPath
)

# XML �h�L�������g�ǂݍ���
$xml = [xml](Get-Content $XmlFile)

# XPath ������Ō����ł���i�r�Q�[�^�[���쐬
$xpath_navigator = $xml.CreateNavigator()

# XPath �ɂ��m�[�h����
$node_iterator = $xpath_navigator.Select($XPath)

# �}�b�`�����m�[�h�𑖍����Ȃ���m�[�h�����o��
while ($node_iterator.MoveNext()) {
    # XmlNode �C���X�^���X���擾
    $current_node = $node_iterator.Current.GetNode()

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

