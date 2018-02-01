#!/bin/bash

#######################################
#
# This is Script.
#
# Author: Thanasi Bakis
# Version: 2.0  (Version 1.0 by Bora Oztekin)
#
# Last modified: Oct 22, 2016
#
#######################################

############## Functions ##############

allowed_users=() # must define now for allowed_users_contains to work

# param 1: value to look for
function allowed_users_contains
{
	for value in ${allowed_users[@]}
	do
		if [ $value = $1 ];
		then
			echo "1"
			exit 0
		fi
	done
	echo "0"
}

# param 1: just pass in $LINENO
function bail_if_needed
{
	if [ ! $? -eq  0 ];
	then
		echo
		echo
		echo "SOMETHING WENT HORRIBLY WRONG AT LINE $1!"
		echo
		echo
		exit 1
	fi
}

#######################################

##### 0 Verify root priviliges ########
if [ ! $(whoami) = "root" ];
then
	echo "Please try again with root priviliges..."
	exit 1
fi

##### 1 Forensics Questions ###########

read -p "Have you solved your forensics questions first? Press enter when you have..."
echo

##### 2 Users #########################

readme_users=()
default_users=()
current_users=()
rogue_users=()

echo "Enter each allowed username in the readme. Press enter when you're done:"
while read -p "--> " username
do
	readme_users=(${readme_users[@]} $username)
	if [ -z $username ]
	then
		break
	fi
done

while read line
do
	length=$(expr index "$line" ":")
	default_users=(${default_users[@]} ${line:0:$(($length - 1))})
	bail_if_needed $LINENO
done < default_passwd

while read line
do
	length=$(expr index "$line" ":")
	current_users=(${current_users[@]} ${line:0:$(($length - 1))})
	bail_if_needed $LINENO
done < /etc/passwd
allowed_users=("${readme_users[@]}" "${default_users[@]}")

bail_if_needed $LINENO

for username in ${current_users[@]}
do
	found="$(allowed_users_contains $username)"
	if [ "$found" = "0" ];
	then
		rogue_users=(${rogue_users[@]} $username)
	fi
	bail_if_needed $LINENO
done

echo "The following are rogue users:"
for username in ${rogue_users[@]}
do
	echo "--> $username"
done

echo
read -p "Confirm deletion of these users? Enter y/n... " flag
if [ $flag = "y" ];
then
	# Delete all rogue users
	echo "Deleting rogue users..."
	for username in ${rogue_users[@]}
	do
		deluser --remove-home $username > /dev/null # so it's silent
		bail_if_needed $LINENO
	done
else
	echo "Will not delete any users."
fi

bail_if_needed $LINENO

echo "Locking root account... "
passwd -l root > /dev/null # so it's silent

echo "Disabling guest login... "
echo "" > .temp
while read line
do
	if [[ ! $line =~ ^allow-guest=[a-z]+ ]];
	then
		echo $line >> .temp
	fi
done < /etc/lightdm/lightdm.conf
echo "allow-guest=false" >> .temp

cat .temp > /etc/lightdm/lightdm.conf # If I use cat > instead of move, permissions should remain
cat .temp > /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

bail_if_needed $LINENO

##### 3 Password Security #####

# Install libpam-cracklib
echo "Installing cracklib... "
apt-get -y install libpam-cracklib > /dev/null # so it's silent

cat default_common-password > /etc/pam.d/common-password
cat default_common-auth > /etc/pam.d/common-auth

bail_if_needed $LINENO

# Modify password age rules
echo "Setting password age and length rules... "
cat default_login.defs > /etc/login.defs

bail_if_needed $LINENO

# Change passwords for all allowed users
echo "Changing users' passwords... "
for username in ${readme_users[@]}
do
	echo $username":!Tr0yH5" | chpasswd
	bail_if_needed $LINENO
done

bail_if_needed $LINENO

##### 4 Firewall #####

echo "Enabling UFW... "
ufw enable > /dev/null # so it's silent

bail_if_needed $LINENO

##### 5 SSH #####

echo "Configuring SSH... "
cat default_sshd_config > /etc/ssh/sshd_config

bail_if_needed $LINENO

##### 6 Files #####

echo
echo "The program will now look for media files."
echo "Note how insecure plaintext files will not be detected."
echo "If there are any media files you wish to keep, please move them to the root / directory now."
read -p "Press enter when you are ready... "

echo "Looking for media files... "

MP3s=$(find /home -name "*.mp3")
OGGs=$(find /home -name "*.ogg")
MP4s=$(find /home -name "*.mp4")
M4Rs=$(find /home -name "*.m4r")
JPGs=$(find /home -name "*.jp*")
PNGs=$(find /home -name "*.png")

bail_if_needed $LINENO

media_files=($MP3s $OGGs $MP4s $M4Rs $JPGs $PNGs)

echo "The following media files were found:"
for file in ${media_files[@]}
do
	echo "--> $file"
done

read -p "Delete these files? Enter y/n... " flag
if [ $flag = "y" ];
then
	echo "Deleting media files... "
	for file in ${media_files[@]}
	do
		rm $file
		bail_if_needed $LINENO
	done
else
	echo "Media files will not be deleted."
fi

bail_if_needed $LINENO

##### 7 Software #####

# Configure update repos
echo "Configuring update sources..."
cat default_sources.list > /etc/apt/sources.list

# Delete specific software
read -p "Should apache2 be removed? Enter y/n... " flag
if [ $flag = "y" ];
then
	echo "Removing apache2..."
	apt-get -my purge apache2 &> /dev/null # so it's silent
else
	echo "Will not remove apache2."
fi

read -p "Should samba be removed? Enter y/n... " flag
if [ $flag = "y" ];
then
	echo "Removing samba..."
	apt-get -my purge samba* &> /dev/null # so it's silent
else
	echo "Will not remove samba."
fi

read -p "Should vsftpd/openssh-sftp-server be removed? Enter y/n... " flag
if [ $flag = "y" ];
then
	echo "Removing vsftpd..."
	apt-get -my purge vsftpd openssh-sftp-server &> /dev/null # so it's silent
else
	echo "Will not remove vsftpd/openssh-sftp-server."
fi

echo "Removing ftp, telnet, bind9, medusa, vino, netcat"
apt-get -my purge ftp telnet bind9 medusa vino netcat* > /dev/null # so it's silent

printf "We made it! Remember to check a couple of things though:\n"
printf "-- Double check the update policy\n"
printf "-- Check if SSH configured properly\n"
printf "-- Just check everything :)\n"
printf "Now exiting...\n"
exit 0
