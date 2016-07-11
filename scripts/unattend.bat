@echo off
echo Setting up Autounattend, please wait...
REM copy a:\SetupComplete.cmd c:\Windows\Setup\scripts\SetupComplete.cmd
mkdir C:\Windows\Panther\Unattend
copy a:\postunattend.xml c:\Windows\Panther\Unattend\unattend.xml
