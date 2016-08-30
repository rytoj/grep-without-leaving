#!/bin/bash

DATA="sample.txt"

#
function recognize_and_run(){
	if [[ "$type" == "file" ]]; then
		grep -i --color -m 25  "$word" "$DATA"
	elif [[ "$type" == "program" ]]; then
		"$DATA" | grep -i --color -m 25  "$word" 
	else
		grep -i --color -m 25  "$word" "$DATA"
	fi
	
}


if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "Usage: `basename $0` [file-name]"
  echo "Usage: `basename $0` new [file-name] [new-entry]"  
  exit 1
fi

#Adding new entry
if [ $1 = "new" ] ; then
	echo "${*:3}" >> "$2"
	echo \"${*:3}\" added to \'$2\'
exit 0
fi


if [ $(which "$1") ]; then
	DATA="$1"
	type="program"
fi

if [[ -e "$1" ]]; then
	DATA="$1"
	type="file"
fi



clear
char=" "
echo -n "Search_: "
while IFS= read -rn1 char;  do
	clear
	word="$word$char"

#Check if Backspace is pressed
if [[ $char == $'\177' ]]
    then
        word=${word%?}
        word=${word%?}
    fi
#Check for empty string
	if [[ -z "$word" ]]; then
		echo "--"
	else
		recognize_and_run
	fi
	echo -n "Search: "
	echo -n "$word"

done
