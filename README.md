# Scripts
various scripts for saving time / semi automating arbitrary tasks.

### extract_tgz.sh
This script will extract all .tgz archives in the current working directory, create a directory named the same as the archive (less the .tgz extension) and extract the contents into the respective directories.

### mulit_port_isolate.sh
This script takes a file that contains a list of nmap xml files and prints the open ports into a file named after each input file. the output is only a list of open port numbers.
  
  Original author: https://github.com/kpelesz/auto

### port_isolate.sh
Takes a nmap.xml file as input and prints out the unique and sorted open ports.
  Original author: https://github.com/kpelesz/auto

### nc_http_check.sh
This script takes a file which contains on each line an IP (or URL) then a single port number and sends a generic HTTP GET request to each IP and port in the file using netcat.  

sample input file: 
```
192.168.1.1 80
192.168.1.2 443
```
  Original author: https://github.com/kpelesz/auto
  
 ### nccheck.sh
This script takes a file which contains on each line an IP (or URL) then a single port number and sends random data to each IP and port in the file using netcat.  

sample input file: 
```
192.168.1.1 23
192.168.1.1 25
``` 
  Original author: https://github.com/kpelesz/auto


### ncgnamp.sh
This script takes an nmap.gnamp file as the input, and sends either generic HTTP GET request or random data to each IP and open port.  It currently only sends data to TCP ports and doesnt check nmap for UDP/TCP. (future update to add this functionality). This script is similar to the two nc check scripts listed above, but is more automated, great for large nmap scans. 


### nmap-xml-to-csv.py
Converts nmap.xml files to .csv for use in worksheet/excel.
This script is originate by Didier Stevens, modified by Sumedt Jitpukdebodin then copied and modified by myself @Freakazoidile
https://github.com/Freakazoidile/nmap-xml-to-csv

### nmap_host_extractor.sh
This script takes a gnmap scan as input and extracts IP's based on popular services and outputs IPs into a file based on the service name.

### qualys_combine.sh
This script combines qualys .csv scans that are in the current working directory into a single csv. It strips the 'headers' that show the scan time, who ran the scan, etc.


### dirb.sh
This script takes the output of web_extractor.sh as input (http_extracted.txt and https_extracted.txt) and runs dirb against each target. It is multithreaded and by default will run 5 processes of dirb. edit to your liking.
