#!/bin/bash
#just grabs a file
DL_DIR="/target/dir"
CURL_OPT="-A Mozilla/5.0 --compressed -e http://www.google.at -p proxyip:proxyport"
rm -f $DL_DIR/passwords.txt
curl $CURL_OPT http://www.domain.com/passwords.txt | sed -e 's/^[ \t]*//' | sort | uniq -u > $DL_DIR/passwords.txt
chmod 0777 $DL_DIR/passwords.txt
exit 0
