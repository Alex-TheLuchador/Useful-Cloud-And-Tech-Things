$teams = Get-Process Teams -ErrorAction SilentlyContinue

# checking if teams is running
# is not necessary, I was just
# testing out Get-Process
if ($teams) {
    Write-Warning "Teams is running!"
    Write-Warning "This function will close Teams & Outlook."
    $query = Read-Host "Do you wish to continue (yes/no)"
    if ($query -eq 'yes') {
        taskkill /im teams.exe /f
        taskkill /im outlook.exe /f
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\cache" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\blob_storage" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\databases" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\GPUcache" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\IndexedDB" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\Local Storage" -Recurse -Force | Remove-Item -Force -Recurse
        Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Teams\tmp" -Recurse -Force | Remove-Item -Force -Recurse
    }
    else {
        Write-Output "Clear teams cache aborted."
    }
}