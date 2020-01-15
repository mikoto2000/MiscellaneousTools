<#
.SYNOPSIS
XML ファイルが XML Schema に準拠しているか検証します。

.PARAMETER XmlFile
XML ファイル

.PARAMETER XsdUri
XSD URI

.PARAMETER XsdFile
XSD ファイル

.EXAMPLE
validate_xml.ps1 -XmlFile target_file.xml -XsdUri 'http://www.contoso.com/books' -XsdFile schema_file.xsd
#>

param(
    [Parameter(Mandatory=$true, HelpMessage="XML file.")]
    [string]$XmlFile,
    [Parameter(Mandatory=$true, HelpMessage="XSD URI.")]
    [string]$XsdUri,
    [Parameter(Mandatory=$true, HelpMessage="XSD file.")]
    [string]$XsdFile
)

try {
    $xml_reader_settings = [System.Xml.XmlReaderSettings]::new()
    $_ = $xml_reader_settings.Schemas.Add($XsdUri, $XsdFile)
    $_ = $xml_reader_settings.ValidationType = [System.Xml.ValidationType]::Schema
    
    $xml_reader = [System.Xml.XmlReader]::Create([string]$XmlFile, [System.Xml.XmlReaderSettings]$xml_reader_settings)
    $xml_document = [System.Xml.XmlDocument]::new()
    $_ = $xml_document.Load($xml_reader)

    exit 0
} catch {
    Write-Error $_.Exception.Message
    exit 1
} finally {
    $xml_reader.Close()
}

