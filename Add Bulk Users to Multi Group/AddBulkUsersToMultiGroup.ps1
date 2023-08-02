## Add Users to multiple Groups
$Items = import-csv .\AUserToMultiGroup.csv
$Items | ForEach-Object {
  $SamAccountName = $_.SamAccountName
  $Groups = ($_.Groups).split(" ")
  foreach ($Group in $Groups)
  {
    "Adding $SamAccountName to the following group: $Group"
     Add-ADGroupMember -Identity $Group $SamAccountName
  }      
}
