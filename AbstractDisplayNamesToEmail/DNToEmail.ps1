## Get Email using DisplayNames
$UserNames = Import-Csv C:\Users\cvo\Desktop\DisplayNames.csv
ForEach ($User in $UserNames) {
    $dn = $User.Users
    Get-ADUser -Filter {displayName -like $dn} -Properties *| Select EmailAddress | Export-CSV C:\Users\cvo\Desktop\Result.csv -Append
}
