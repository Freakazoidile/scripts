#!/bin/bash

# Takes script takes the output of web_extractor.sh file as input, http_extracted and https_extracted and runs dirb.
# Update: Removed multithreading. did not work well. 
# Todo: Revisit multithreading.
#set -m #enable JOB control

for i in $(cat http_extracted.txt); do
	#while [ `jobs | wc -l` -ge 5 ]; do
	#	sleep 15
	#done
	echo "$i"
	name="$(echo $i | grep $i |  sed 's/:/-/g')"
	dirb http://$i /usr/share/dirb/wordlists/big.txt -o http_$name.dirb
done



for i in $(cat https_extracted.txt); do
	#while [ `jobs | wc -l` -ge 5 ]; do
	#	sleep 15
	#done
	echo "$i"
	name="$(echo $i | grep $i |  sed 's/:/-/g')"
	dirb https://$i /usr/share/dirb/wordlists/big.txt -o https_$name.dirb
done

wait
