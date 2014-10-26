#!/bin/bash
#kinda crap cleaner for linux
if [ -z "$1" ]
then
            echo "please define a directory to scan"
            exit 1
fi

#remove the link spam stuff
find $1 \( -name "*.url" -o -name "*.URL" \) -type f -exec rm {} \;

#remove usenet leftovers
find $1 -name "*.par2" -type f -exec rm {} \;
find $1 -name "*.nzb" -type f -exec rm {} \;

#remove old torrent files
#do not use this on your rtorrent root as it will really clean up
#find $1 -name "*.torrent" -type f -exec rm {} \;
#find $1 -name "*.cache" -type f -exec rm {} \;
#find $1 -name "*.rtorrent" -type f -exec rm {} \;
#find $1 -name "*.btorrent_resume" -type f -exec rm {} \;
#find $1 -name "*.meta" -type f -exec rm {} \;

#remove crtmpserver leftovers
#find $1 -name "*.meta" -type f -exec rm {} \;
#find $1 -name "*.seek" -type f -exec rm {} \;

#remove firefox broken downloads
#find $1 -name "*.part" -type f -exec rm {} \;

#remove samples
find $1 \( -name "*sample*" -o -name "*Sample*" -o -name "*SAMPLE*" \) -type f -exec rm {} \;

#remove empty directories
#find $1 -type d -empty -exec rmdir {} \;

#remove leftover sfv checks
#find $1 -name "*.sfv" -type f -exec rm {} \;

#remove old logfiles (ftprush, flashfxp, jdownloader...)
#find $1 -name "*.log" -type f -exec rm {} \;

#remove all the weird windows stuff
#find $1 \( -name "Thumbs.db" -o -name "thumbs.db" -o -name "thumb.db" -o -name "Thumb.db" \) -type f -exec rm {} \;
#find $1 -name "*.rtf" -type f -exec rm {} \;

exit 0
