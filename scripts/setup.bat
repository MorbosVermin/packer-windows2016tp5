@echo off
REM 
REM Provisions the system
REM
 
echo Installing Chocolatey, please wait...
powershell.exe -executionpolicy bypass -File a:\install-choco.ps1

echo Installing Git and Puppet Agent, please wait...
C:\ProgramData\chocolatey\bin\choco install -y git.install puppet-agent

REM The following statements are broken out into separate
REM batch/powershell scripts to run later if needed (if 
REM for instance a TLS/SSL check fails :/

REM Puppet Module: Chocolatey
call a:\install-puppet.bat

REM Install Guest Additions
powershell.exe -executionpolicy bypass -file A:\install-guest-additions.ps1

REM Setup for SysPrep by Packer later on (once WinRM is running) 
call A:\unattend.bat

REM Make sure this is the last statement!
REM Packer will connect after this and run SysPrep and shutdown the machine.
powershell.exe -executionpolicy bypass -file A:\enable-winrm.ps1
