#!/bin/bash

#Set arguement variables
FILENAME=$1                     #Filename to be used
STYPE=$2                        #Script type
DATE=`date +%b" "%d" "%H":"%M`  #Date
AUTHOR=$USER                    #User who created file

###Validate User input###
#Check for blank arugments
if [ -z $FILENAME  ] || [ -z $STYPE ]; then
        echo "You forgot an argument!"
        exit 1
fi

#Check for too many arugments, output #Args
if [ $# -gt 2 ]; then
        echo "Too many arguments [$#]"
        exit 1
fi


###Creating the file###

#Append file extension to FILENAME variable
case $STYPE in

        bash)
                FILENAME+=".sh"
                ;;
        ruby)
                FILENAME+=".rb"
                ;;
        python)
                FILENAME+=".py"
                ;;
        perl)
                FILENAME+=".pl"
                ;;
        *)
esac

#Check to see if file exists, if it does prompt user to overwrite


if [ -e $FILENAME ]; then
        read -p "This file already exists! Would you like to overwrite? [y/n] " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
                echo
        else
                echo;exit 1
        fi
fi

##CREATE THE FILE?

touch $FILENAME

###Check for script type and append proper extension###

#Set variable for path to stype
VAR=$(which $STYPE)

#If it doest exist, return error and exit
if [ -z $VAR ]; then
        echo "Invalid script type!"
        exit 1
#If it does exist write it out to the file
else
        echo "#!$VAR" > $FILENAME

fi


#Add in generic file header (add in function to do this with more details)

echo " " >> $FILENAME
echo "#-------------------------#" >> $FILENAME
echo "#-File: $FILENAME" >> $FILENAME
echo "#-Author: $AUTHOR" >> $FILENAME
echo "#-Started: $DATE" >> $FILENAME
echo "#-Updated:" >> $FILENAME
echo "#-------------------------#" >> $FILENAME

#Open newly created document

vim + $FILENAME
