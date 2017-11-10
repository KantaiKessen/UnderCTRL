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
printf "[SeatDefaults]\ngreeter-show-manual-login=true\ngreeter-hide-users=true\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-myconfig.conf
printf "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Download-Upgradable-Packages \"1\";\nAPT::Periodic::AutocleanInterval \"7\";\nAPT::Periodic::Unattended-Upgrade \"1\";"
cp ./50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
#must download clean files folder