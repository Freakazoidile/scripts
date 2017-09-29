#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo 'Takes a gnmap file as input, and sends a bunch of "a" or an HTTP GET request  to netcat based on the open ports for the IPs in the nmap scan.'
	echo ''
	echo '"nccheck tcpnmap.gnmap"'
	exit
fi

file=$1

payload="aaaaaaaaaaaaaaaaa"
#payload="GET / HTTP/1.1
#
#"


cat $file | grep 'Host' | grep open > result

while read i; do
	ip="$(echo $i | awk '!/#/' | grep "open/" | sed -e 's/Host: //g' -e 's/ (.*//g')"

	ports="$(echo $i | cut -d ':' -f 3- | tr ',' '\n' | cut -d '/' -f1)"
		
	for x in $(echo $ports); do
		echo "======================="
		echo $ip
		echo "======================="
		echo $payload | nc -w 10 $ip $x 	
		echo ""
		echo ""
	done
done< result


