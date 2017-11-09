#!/bin/bash
if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi
cp /etc/pam.d/common-auth ./common-auth-bkup
cp /etc/pam.d/common-password ./common-password-bkup
cp /etc/login.defs ./login.defs-bkup
cp ./common-auth /etc/pam.d/common-auth
cp ./common-password /etc/pam.d/common-password
cp ./login.defs /etc/login.defs
echo "[SeatDefaults]\ngreeter-show-manual-login=true\ngreeter-hide-users=true\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-myconfig.conf
#must download clean files folder