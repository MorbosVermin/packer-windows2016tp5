@echo off
REM
REM Oh good gawd...see https://docs.puppet.com/windows/troubleshooting.html#error-messages for more information.
REM 
echo Downloading GeoTrust Global CA certificate, please wait...
powershell.exe -executionpolicy bypass -Command "(new-object net.webclient).DownloadFile('https://www.geotrust.com/resources/root_certificates/certificates/GeoTrust_Global_CA.pem', 'GeoTrust_Global_CA.pem')"

echo Importing GeoTrust Global CA certificate into Windows certificate store (Root), please wait...
certutil -addstore Root GeoTrust_Global_CA.pem 

REM
REM This will fail if the above certificate download or import fail. 
REM 
echo Installing Puppet Chocolatey Module, please wait...
"C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install chocolatey-chocolatey
