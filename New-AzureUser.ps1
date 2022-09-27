# Check if Az module is installed.
# If not, it will be installed and
# proceed with the rest of the script.
if (Get-Module -ListAvailable -Name Az) {
    Write-Host "Azure module installed..."
}
else {
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
    # Sign into Azure account
    Connect-AzAccount
}

# Gather required details for the Azure user
$DisplayName = Read-Host -prompt "New user display name"
$MailNickname = Read-Host -prompt "New user mail nickname"
$UserPrincipalName = Read-Host -prompt "New user UPN"
$Password = Read-Host -AsSecureString -Prompt "New user password"

New-AzADUser -DisplayName $DisplayName -MailNickname $MailNickname -UserPrincipalName "$UserPrincipalName@domainname.com" -Password $Password