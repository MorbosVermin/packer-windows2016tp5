#!/bin/bash
#
# Copyright (c)2015 NASA GSFC ICAM
# Brennan Hay <brennan.hay@nasa.gov>
# Tadd Buffington <tadd.a.buffington@nasa.gov>
# Mike Duncan <michael.d.duncan@nasa.gov>
# 
# Provisioning script for CentOS 7 Minimal server.
#

# Check for VM_TYPE. If not given as argument, then it must
# be defined within the environment.
[ ! -z "$1" ] && VM_TYPE=$1

# Enable EPEL
yum -y install epel-release && yum -y update

# Install Packages
yum -y install joe figlet puppet facter ruby-shadow && \
	systemctl enable puppet && \
	systemctl start puppet

# Install Virtualbox Guest Additions or VMware OpenVM Tools
if [ $PACKER_BUILDER_TYPE == "virtualbox-iso" ]; then
	echo "Installing Virtualbox Guest Additions; please wait..."
	mount /dev/sr0 /mnt && cd /mnt && ./VBoxLinuxAdditions.run
	if [ $? -ne 0 ]; then
		echo
		echo "Warning, Virtualbox Guest Additions failed to install properly."
		echo "You may need to install manually."
		echo
	fi
else
	echo "Enabling VMware yum repo; please wait..."
	cat > /etc/yum.repos.d/vmware.repo <<EOF
[vmware-tools]
name = VMware Tools
baseurl = http://packages.vmware.com/packages/rhel7/x86_64/
enabled = 1
gpgcheck = 1
EOF
	
	yum -y update
	
	echo "Installing OpenVM Tools for VMWare; please wait..."
	yum -y install open-vm-tools open-vm-tools-deploypkg
fi

# Write MotD
figlet "CENTOS 7 MINIMAL" > /etc/motd
echo "Build Time: `date`" >> /etc/motd
