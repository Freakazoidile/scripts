#!/bin/bash

#Requires aha to output the results into html file. 
#nc iplist.txt

#Future improvements - Use nmap xml file
#Future improvements - Multi-process?

if [[ $# -eq 0 ]]; then
	echo '	This will send a bunch of As to netcat based on a provided list of ips and ports.'
	echo ''
	echo '"nccheck iplist.txt"'
	exit
fi

#Variables, future improvements - check the file exists

valid=()
list=$1
touch a.txt | echo "aaaaaaaaaaaaaaaaaaaa" > a.txt

while read i; do
		echo $i
		timeout 10 nc $i < a.txt
		exits=$?
		if [[ $exits -ne 124 ]]; then
		valid+=("$i")
		fi
	done <$list


run ()
{
for n in "${valid[@]}"; do
		echo $n  
		nc -w 10 $n < a.txt
		echo ""
		echo ""
	done
}
run $valid | aha >$1-nccheck.html
