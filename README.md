# Everything is Under CTRL
If you are reading me after you've used these scripts, then you need help.
### Table of Contents
1. [How Do I Use This?!](#how-do-i-use-this?!)
2. [Script Order](#script-order)
3. [What Do They Do](#what-do-they-do)

#### How Do I Use This?!
   It's pretty easy. Put it on your desktop, make a users and programs files, and then run the scripts. You will need to put the users from your read me in the users file, and put the neccessary packages (make sure it is readeble by apt-get) in the programs file.
  
#### Script Order
1. starter
2. Forensics Questions
3. basicscript
4. replace (Use the correct version)


#### What Do They Do
##### Starterscript
starterscript installs necessary tools, such as vim, ClamAV, chkrtkit, and enables the firewall.
##### basicscript
Although It is named "basic script", it is far from basic. This script will add users to the system from the users file, and remove all users not in the users file. It will also add necessary programs and remove unecessary ones. It is recommended that you do anything you need to do before you use it.
##### replace
This script copies clean versions of the security policy files and replaces them in `/etc/pam.d` It is strongly recommended you use the version suggested for your OS. This script also disables guest access.

