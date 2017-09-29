#!/bin/sh

ls | grep .tgz | sed 's/.tgz//' > extract_list.txt


for i in $(cat extract_list.txt); do mkdir $i; tar -xvf $i.tgz -C $i/; done 
