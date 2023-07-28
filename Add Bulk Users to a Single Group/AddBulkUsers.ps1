## Please go to ReadMe for more information.
Import-CSV ".\Import Location of CSV File" | Foreach-Object {
  $aduser = Get-ADUser -Filter "Mail -eq '$($_.Mail)'"
  if( $aduser ) {
    Write-Output "Adding user $($aduser.SamAccountName) [Insert name of DL/SG here]"
    Add-ADGroupMember -Identity [Insert name of DL/SG here] -Members $aduser
  } else {
    Write-Warning "Could not find user in AD with email address $($_.Mail)"
  }
}
