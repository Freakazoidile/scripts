#!/bin/bash

# Takes the output of smb_extractor.sh as input and runs enum4linux against each IP, saving the output to a file called enum4linux_IPADDRESS.txt
# TO DO: Make it multithreaded

for i in $(cat smb_extracted.txt); do
	echo "$i"
	enum4linux -a $i > enum4linux_$i.txt
done


