$ThePath = Read-Host "Enter Path to Scan: "

(Get-ChildItem $ThePath | Get-Acl).Access.IdentityReference | select -Unique