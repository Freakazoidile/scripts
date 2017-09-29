#!/bin/bash

if [ $# -eq 0 ]
  then
    echo No arguments supplied!
    echo 
    echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
    echo 
    echo Usage: ./portisolate inputfile
    echo inputfile contains a nmap.xml file name with relative or absolute path on each line.
    echo
    echo To get list of files run: find . | grep xml > inputfile
    echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
    echo

    exit 1
  
fi


for file in $(cat $1);do

  #new_name=$(echo $file |  sed 's/\///' | tail -n1 | cut -d '.' -f 1)

  echo $file
  echo
  cat $file | grep "open" | grep -o "portid=\"[0-9]*" | sed 's/portid=\"//g' | sort -n | uniq | tr '\n' ',' | sed 's/,/, /g' > $file.txt
  
  mv $file.txt . 

  echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
  echo 

done


echo \=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=   FINISHED   \=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=

# PUT EACH FILE NAME INTO THE RESULTS FILE
ls | grep .xml.txt > results

# RUN THE FOLLOWING TO CAT THE OUTPUT OF EACH RESULT.
#for i in $(cat results); do echo $i; cat $i; done


