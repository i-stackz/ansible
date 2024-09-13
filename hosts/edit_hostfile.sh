#!/usr/bin/env bash

# Description: This script will ask the user if he wishes to remove
# any servers listed within the given host file.

# Author: i-stackz
# Date: 8/30/2024

# variables
FILE=$1;
declare ANSWER;

# check that FILE is not empty
if [[ -z $FILE ]]
then
  # display message
  echo -e "ERROR! No host file given. Try again!";
  exit 1;
fi

# prompt user for input
read -p "Do you wish to remove any servers from the host file? [yes/no] " ANSWER;

# convert ANSWER to lowercase
${ANSWER,,};

# if statement to check user's input
if [[ $ANSWER == 'y' || $ANSWER == 'yes' ]]
then
  # display message
  echo -e "\nYou've responded 'yes', will now begin to remove any servers found within the given host file.";

  # sed command to remove hostnames that contain 'srv'
  sed -r -i '/..+srv..+/d' $FILE;

  # sed command to remove hostnames that contain 'fs'
  sed -r -i '/..+fs..+/d' $FILE;

  # 2nd version of sed command to remove hostnames that contain 'fs'
  sed -r -i '/.*fs.*/d' $FILE;
  
  # sed command to remove hostnames that contain 'ns'
  sed -r -i '/..+ns..+/d' $FILE;

  # sed command to remove hostnames that contain 'web'
  sed -r -i '/.*web*./d' $FILE;

  # sed command to remove hostnames that contain 'db'
  sed -r -i '/.*db.*/d' $FILE;



  # code to convert IPv4 addresses into hostnames goes here

  # display message
  echo -e "Done!\n";

  # exit successfully
  exit 0;
elif [[ $ANSWER == 'no' || $ANSWER == 'n' ]]
then
  # code to convert IPv4 addresses into hostname

  # exit successfully
  exit 0;
fi