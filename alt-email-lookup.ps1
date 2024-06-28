# Quick and dirty powershell script to spit out a list of email addresses based on passed alternate login IDs
# https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/operations/configuring-alternate-login-id

# Specify the path to the file containing the list of alternate logon IDs
$filePath = "C:\Users\test\Desktop\userlist.txt"

# Read the file and store alternate logon IDs in an array
$alternateLogonIDs = Get-Content $filePath

# Import the Active Directory module
Import-Module ActiveDirectory

# Iterate through each alternate logon ID and retrieve email address
foreach ($logonID in $alternateLogonIDs) {
    try {
        $user = Get-ADUser -Identity $logonID -Properties EmailAddress -ErrorAction Stop
        Write-Host "Email Address: $($user.EmailAddress)"
    } catch {
        Write-Host "Alternate Logon ID: $logonID not found in Active Directory"
    }
}
