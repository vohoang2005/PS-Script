## Good to use Domain Admin Account, as it might run into Access Deny issue when running this script.

$ThePath = Read-Host "Enter Path to Scan: "
$ScanFolders = Get-ChildItem -Path $ThePath -Recurse | Where {$_.PSIsContainer}
$Users = (Get-ADUser "EnterAccountHere").SamAccountName
Foreach ($Folder in $ScanFolders) {
    # Name to rights hash table
    $UserRights = @{}
    $Folder.GetAccessControl().Access | ForEach-Object {
        $Name = $_.IdentityReference -replace ".+\\",""
        $UserRights."$Name" = $_.FileSystemRights
    }
    # Compare against acl
    $MatchedUsers = Compare-Object -ReferenceObject $Users -DifferenceObject @($UserRights.Keys) -IncludeEqual -ExcludeDifferent
    If (($MatchedUsers | Measure).Count -gt 0) {
        Foreach ($User in $MatchedUsers.InputObject) {
            Write-Host "$User has the rights $($UserRights."$User") on directory $($Folder.FullName)"
        }
    }
}
