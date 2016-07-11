Write-Host "Installing Virtualbox Guest Additions for Windows, please wait..."
certutil -addstore -f "TrustedPublisher" A:\oracle.cer
$p = Start-Process "E:\VBoxWindowsAdditions.exe" -ArgumentList "/S" -Wait -NoNewWindow -PassThru
$p.HasExited
$p.ExitCode
