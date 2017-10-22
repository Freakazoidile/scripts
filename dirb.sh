#!/bin/bash

# Takes script takes the output of web_extractor.sh file as input, http_extracted and https_extracted and runs dirb.
# It is multithreaded, will run up to 5 instances of dirb at once. you can edit the value in the while loop to your liking. Just don't overload your machine by not capping it with a large number of targets.

set -m #enable JOB control

for i in $(cat http_extracted.txt); do
	while [ `jobs | wc -l` -ge 5 ]; do
		sleep 15
	done
	echo "$i"
	name="$(echo $i | grep $i |  sed 's/:/-/g')"
	dirb http://$i /usr/share/dirb/wordlists/big.txt -o http_$name.dirb &
done



for i in $(cat https_extracted.txt); do
	while [ `jobs | wc -l` -ge 5 ]; do
		sleep 15
	done
	echo "$i"
	name="$(echo $i | grep $i |  sed 's/:/-/g')"
	dirb https://$i /usr/share/dirb/wordlists/big.txt -o https_$name.dirb &
done

wait
