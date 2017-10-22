#!/bin/sh

if [[ $# -eq 0 ]]; then
	echo 'Takes a gnmap file as input, and extracts open ports: 80, 443, 8080, 8443, or containing ssl or https in the service name. '
	echo 'Ports 80 and 8080 are placed into a file named "http_extracted.txt", 443, 8443 and ssl/https are extracted to https_extracted.txt'
	echo 'The output of the scripts can be used as input for dirb or nikto. The https_extracted file needs to be edited to work with nitko by adding "https://" to the start of each line.'
	echo 'The script WILL NOT EXTRACT 3389 (RDP) or microsoft HTTPAPI.'
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
		port="$(echo $x | cut -d '/' -f 1| cut -d '.' -f2)"
		if [[ -z "$ip" ]] || [[ $port == "3389" || $x == *"HTTPAPI" ]]; then
			continue
		fi

		if [[ $port == "443" || $port == "8443" || $x == *"https"* || $x == *"ssl"* ]]; then
			echo $ip:$port >> https_extracted.txt
		elif [[ $port == "80" || $port == "8080" || $x == *"http"* ]]; then
			echo $ip:$port >> http_extracted.txt
		fi


	done
done< result
