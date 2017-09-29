#!/bin/bash

if [ $# -eq 0 ]
  then
    echo No arguments supplied!
    echo 
    echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
    echo 
    echo Usage: ./portisolate inputfile
    echo inputfile is an nmap.xml file.
    echo
    echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
    echo

    exit 1
  
fi


cat $1 | grep "open" | grep -o "portid=\"[0-9]*" | sed 's/portid=\"//g' | sort -n | uniq | tr '\n' ',' | sed 's/,/, /g'

