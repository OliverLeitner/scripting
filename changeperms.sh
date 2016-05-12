#!/bin/bash
# change file and folder permissions recursively
HOME=$1
find $HOME -type d -exec chmod 755 {} \;
find $HOME -type f -exec chmod 644 {} \;
#echo $HOME
exit 0
