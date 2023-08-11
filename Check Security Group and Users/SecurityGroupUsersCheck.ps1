#Start Folder#
$startpoint = "Enter the Network Path Here"

#Define function for filepaths#
$Filepath = Get-ChildItem -path $startpoint | Where {$_.PSIsContainer} | select fullname

#Find ACL for each filepath#
ForEach ($Folder in $Filepath) { 
   $ACLObjects =  Get-Acl $folder.fullname
    }

#Pull information from ACLs#
foreach ($acl in $ACLObjects)  {
    $accessEntries = $acl.Access
    $GroupName = [System.Security.Principal.NTAccount]$IdentityReference.Value
    Write-Host "For Folder:" $folder.FullName
    $accessEntries | ForEach-Object {
        Write-Host "Group Name: $($_.IdentityReference.toString().split('\')[1])"
        Write-Host "Access Rights: $($_.AccessControlType) $($_.FileSystemRights)"
        Write-Host "List of Users:"
        Get-ADGroupMember -Identity $_.IdentityReference.toString().split('\')[1] -recursive| Where {$_.identityreference -notin @("BUILTIN\Administrators", "BUILTIN\Users", "NT AUTHORITY\SYSTEM", "System", "domain users")}| Select-Object Name | Select-Object -ExpandProperty Name
        Write-Host " "
        
        
    }
    Write-Host " "
}
