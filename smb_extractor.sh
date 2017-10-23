#!/bin/bash

if [[ $# -eq 0 ]]; then
        echo 'Takes a gnmap file as input, and extracts IP with port 139 or 445 open (SMB). Does not extract duplicates if both ports are open.                                                                                                       0, 8443, or containing ssl or https in the service name. '
        echo ''
        echo '"smb_extractor.sh nmap.gnmap"'
        exit
fi

file=$1


cat $file | grep 'Host' | grep open > result

while read i; do
        ip="$(echo $i | awk '!/#/' | grep "open/" | sed -e 's/Host: //g' -e 's/                                                                                                        (.*//g')"

        ports="$(echo $i | cut -d ':' -f 3- | tr ',' '\n' | tr ' ' '.')"

        for x in $(echo $ports); do
                port="$(echo $x | cut -d '/' -f 1| cut -d '.' -f2)"
                if [[ -z "$ip" ]]; then
                        continue
                elif [[ $port == "445" || $port == "139" ]]; then
                        echo $ip >> smb_extracted.txt
                        break
                fi


        done
done< result
