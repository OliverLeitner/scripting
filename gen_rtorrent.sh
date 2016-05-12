#!/bin/bash
# generating rtorrent needed directories

#user perms
USER="youruser"

#where to generate the tree
ROOT_DIR="/data"

#which directories to generate
#/archive-old/usb/incoming/torrents/share/torrents
GEN_DIRS=( "done" "cache" "incoming" "new" "share" "share/torrents" )

#your systems directory creation command
MKDIR_CMD="mkdir -p"
CHOWN_CMD="chown"
CHMOD_CMD="chmod 0777 -R"

#creating the directories
for dir in "${GEN_DIRS[@]}"
do
	if [ ! -d $ROOT_DIR/$dir ] ; then
		$MKDIR_CMD $ROOT_DIR/$dir
	fi
done

#changing perms
$CHOWN_CMD $USER.$USER -R $ROOT_DIR
$CHMOD_CMD $ROOT_DIR

echo "everything has been generated successfully, now you may run rtorrent"

exit 0
