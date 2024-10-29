#!/usr/bin/env bash

<<"COM"

    Descripiton: This script will edit the generated host list file to only contain servers
    Date: 10/29/2024
    Author: iStackz

COM

# display message
echo -e "The number of parameters given is $#\n";

# parameter check
if [[ $# < 1 ]]
then
    # display message
    echo -e "\nError! No host file supplied";
    echo -e "\nUsage: edit_hostfile_server_only.sh <filename>";

    # error exit
    exit 1;
fi

# check if supplied file exists
if [[ -e $1 ]]
then
    # display message
    echo -e "\nYou have provided $1 as a parameter";
fi

# create a variable
declare ANSWER;

# while loop to prompt user for input
while [[ $ANSWER != 'yes' ]]
do
    # promp user for input
    read -p "Do you want to edit the host file to contain servers only? (yes/no): " ANSWER;

    # if statment to check if $ANSWER == 'no'
    if [[ $ANSWER == 'no' ]]
    then
        # display message
        echo -e "\nYou've answered 'no'. Will now exit the script";

        # normal exit
        exit 0;
    fi
done

# create a temporary file
TEMPFILE=$(mktemp);

## TESTS ##

# add lines to file
#echo $(grep -o "\[all\:vars\]" $1) >> $TEMPFILE;
#echo -e "$(grep -i 'ansible' $1)\n" >> $TEMPFILE;
#echo -e "$(grep -i '^gather' $1)" >> $TEMPFILE;
#sed -i '/^$/d' $TEMPFILE;
#echo -e "\n$(grep -o '\[today\]')" >> $TEMPFILE

#echo -e "$(grep -E 'smf[pv]r.+srv[0-9]{2}' $1)" >> $TEMPFILE;
#echo -e "$(grep -E 'sfm[pv]r.+srv[0-9]{4}' $1)" >> $TEMPFILE;
#echo -e "$(grep -E '.*ns[0-9](\d{2}|\d{4})' $1)" >> $TEMPFILE;

# working regex
#echo -e "$(grep -E '.*srv[0-9].*' $1)" >> $TEMPFILE;
#echo -e "$(grep -E '.*db[0-9].*' $1)" >> $TEMPFILE;
#echo -e "$(grep -E '.+fs[0-9]' $1)" >> $TEMPFILE;
#echo -e "$(grep -E '.*www.*' $1)" >> $TEMPFILE;
#echo -e "$(grep -E '.+exercise[s].+' $1)" >> $TEMPFILE;

# while loop to iterate through host file (recommended by ChatGPT because a for loop would mess up the output)
while IFS= read -r LINE
do
    # if statement to check host file for regex
    if [[ $LINE =~ \[all\:vars\] ]]
    then
        # add line to tempfile
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ ^ansible.*$ ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ ^vars.*$ ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ ^gather.*$ ]]
    then
	# add line to tempfile along with a newline character
        echo -e "$LINE\n" >> $TEMPFILE;
    elif [[ $LINE =~ \n ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ \[today\] ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*srv[0-9].* ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*db[0-9].* ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .+fs[0-9] ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .+ns[0-9]{2}.+ ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*www.* ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .+exercise[s].+ ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*srv[0-9]{4}.* ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*db[0-9]{4}.* ]]
    then
        echo $LINE >> $TEMPFILE;
    elif [[ $LINE =~ .*ns[0-9]{4}.* ]]
    then
        echo $LINE >> $TEMPFILE;
    fi
done < $1; # passes the hostsfile into the while loop


# rename the tempfile to the original hostfile
if [[ -s $TEMPFILE ]]
then
    # rename file
    mv $TEMPFILE $1;

    # display message
    echo -e "\nFile filtered successfully. Only matching hostnames have been kept";
else
    # display message
    echo -e "\nNo matching hostsnames found. Original file is unchanged";

    # remove the tempfile
    rm $TEMPFILE;
fi





