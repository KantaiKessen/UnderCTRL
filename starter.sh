if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi
chmod 755 ./mediafinder/findmedia.sh
chmod 755 ./basicscript/basicscript.sh
chmod 755 './Ubuntu14.04/replace.sh'
chmod 755 './Ubuntu16.04.5LTS/replace.sh'
apt-get install -y libpam-cracklib
apt-get install -y vim
apt-get install -y clamav
apt-get install -y chkrootkit
apt-get install -y nmap
apt-get install -y selinux
ufw enable
update-alternatives --config editor
nmap -sT localhost
touch ./mediafinder/programs
echo "Do the Forensics Questions first, then run basicscript.sh"