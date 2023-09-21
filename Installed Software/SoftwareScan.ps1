invoke-command -ComputerName "insert computer name here" {

$installedSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
foreach($object in $installedSoftware){
    Write-Host $object.GetValue('DisplayName') -NoNewline;
    Write-Host " - " -NoNewline;
    Write-Host $object.GetValue('DisplayVersion')
    }
}