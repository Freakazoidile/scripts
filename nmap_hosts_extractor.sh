#!/bin/bash

if [[ $# -eq 0 ]]; then
        echo 'Takes a gnmap file as input, and extracts common ports and puts each ip into separate files by common service name.'
        echo ''
        echo '"smb_extractor.sh nmap.gnmap"'
        exit
fi

file=$1

declare -i ftpCount
declare -i sshCount
declare -i telnetCount
declare -i smtpCount
declare -i rpcCount
declare -i smbCount
declare -i mssql
declare -i nfsCount
declare -i sql
declare -i httpCount
declare -i httpsCount
declare -i rdpCount



cat $file | grep 'Host' | grep open > nmap_extractor_result

while read i; do
	ip="$(echo $i | grep "open/" | sed -e 's/Host: //g' -e 's/ (.*//g')"

	ports="$(echo $i | cut -d ':' -f 3- | tr ',' '\n' | tr ' ' '.')"

	

	for x in $(echo $ports); do
		port="$(echo $x | cut -d '/' -f 1| cut -d '.' -f2)"
		if [[ -z "$ip" ]] || [[ $x == *"HTTPAPI"* ]]; then
			continue
		elif [[ $port == "21" ]]; then
			echo $ip >> ftp_hosts.txt
			ftpCount+=1
		elif [[ $port == "22" ]]; then
			echo $ip >> ssh_hosts.txt
			sshCount+=1
		elif [[ $port == "23" ]]; then
			echo $ip >> telnet_hosts.txt
			telnetCount+=1
		elif [[ $port == "25" ]]; then
			echo $ip >> smtp_hosts.txt
			smtpCount+=1
		elif [[ $port == "111" ]]; then
			echo $ip >> rpc_hosts.txt
			rpcCount+=1
		elif [[ $port == "445" || $port == "139" ]]; then
			echo $ip >> smb_hosts.txt
			smbCount+=1
		elif [[ $port == "1433" ]]; then
			echo $ip >> mssql_hosts.txt
			mssqlCount+=1
		elif [[ $port == "2049" ]]; then
			echo $ip >> nfs_hosts.txt
			nfsCount+=1
		elif [[ $port == "3306" ]]; then
			echo $ip:$port >> sql_hosts.txt
			sqlCount+=1
		elif [[ $port == "3389" ]]; then
			echo $ip >> rdp_hosts.txt
			rdpCount+=1
		elif [[ $port == "80" || $port == "8080" ]]; then
			echo $ip:$port >> http_hosts.txt
			httpCount+=1
		elif [[ $port == "443" || $port == "8443" || $x == *"https"* || $x == *"ssl"* ]]; then
			echo $ip:$port >> https_hosts.txt
			httpsCount+=1
		elif [[ $x == *"http"* ]]; then
			echo $ip:$port >> http_hosts.txt
			httpCount+=1
		fi


	done
done< nmap_extractor_result


echo '============='
echo 'Stats'
echo '============='
echo 'ftp hosts: '$ftpCount
echo 'ssh hosts: '$sshCount
echo 'telnet hosts: '$telnetCount
echo 'smtp hosts: '$smtpCount
echo 'rpc hosts: '$rpcCount
echo 'smb hosts: '$smbCount
echo 'mssql hosts: '$mssqlCount
echo 'nfs hosts: '$nfsCount
echo 'sql hosts: '$sqlCount
echo 'rdp hosts: '$rdpCount
echo 'http services: '$httpCount
echo 'https services: '$httpsCount
