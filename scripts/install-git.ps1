<# Process before the advent of Chocolatey :)
$url = "https://github.com/git-for-windows/git/releases/download/v2.8.2.windows.1/Git-2.8.2-64-bit.exe"
$webClient = New-Object System.Net.WebClient;

Write-Host "Downloading Git v2.8.2, please wait..."
try  {
	$webClient.DownloadFile($url)
	
	Write-Host "Done! Installing Git, please wait..."
	Start-Process Git-2.8.2-64-bit.exe -ArgumentList "/VERYSILENT /NORESTART" -Wait
	
	Write-Host "Done! Fixing environment for CLI use of Git, please wait..."
	$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
	$newPath=$oldPath+';C:\Program Files\Git\bin'
	Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
	
	Write-Host "Done! Git installation is complete!"
	
}catch{
	Write-Warning "Warning, could not download/install Git package from $($url): $($_.Exception.Message)"
}
#>

# Now the process with Chocolatey...
Install-Package git.install -Verbose
