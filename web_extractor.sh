#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo 'Takes a gnmap file as input and extracts any open port that is: port 80, 443, 8080 or the service name contains "http" or "ssl" and outputs to a file in the format IP:PORT .'
	echo ''
	echo '"nccheck tcpnmap.gnmap"'
	exit
fi

file=$1

cat $file | grep 'Host' | grep open > result

while read i; do
	ip="$(echo $i | awk '!/#/' | grep "open/" | sed -e 's/Host: //g' -e 's/ (.*//g')"

	ports="$(echo $i | cut -d ':' -f 3- | tr ',' '\n' | tr ' ' '.')"
		
	for x in $(echo $ports); do
		if [[ $x == *"80"* || $x == *"443"* || $x == *"8080"* || $x == *"http"* || $x == *"ssl"* ]]; then
			port="$(echo $x | cut -d '/' -f 1 | cut -d '.' -f2)"
			echo $ip:$port >> web_extracted.txt
		
		fi
		

	done
done< result

