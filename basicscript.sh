#!/bin/bash
if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi
#enables firewall
for user in $(cat users); do grep -q $user /etc/passwd || useradd -m -s /bin/bash $user; done
#This adds users to the system, they need to be in a users file
for nuser in $(awk -F: '($3>=1001)&&($1!="nobody"){print $1}' /etc/passwd); do grep -q $nuser users || deluser $nuser; done
#Deletes rouge users
sed -i "/nopasswdlogin:x:119:/c\nopasswdlogin:x:119:$(logname)" /etc/group
#This remove autologin users.
for cpuser in $(awk -F: '($3>=1001)&&($1!="nobody"){print $1}' /etc/passwd); do echo $cpuser':BC=,h+2Ev8sfyLq*!' | chpasswd; done
# adds password for all users.
for program in $(cat programs); do dpkg --get-selections | grep -q  $program || apt-get install $program; done
#installs programs in programs list
for bprogram in $(cat badprograms); do grep -q -e $bprogram -f ./programs || apt-get --autoremove purge $bprogram; done
echo "Now make sure the Sudoers are OK. Also check that sudoers.d doesn't have bad stuff\nrun replace.sh now too."
#removes programs from a set of bad programs that are not in the list of good programs