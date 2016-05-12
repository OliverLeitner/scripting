#!/bin/bash
# backup script
# FINALLY!!!
# must be run as root

#sys vars
GZIP=-3

#i.e. 31-10-2016
DATE=$(date +"%d-%m-%Y")

#btrfs subvolumes to be backed up
SOURCES_STOR=(/storage/covers /storage/nzb)
SOURCES_DB=(/var/lib/mysql)

#where to create snapshots
SNAP_DIR_STOR=/storage/snaps/$DATE
SNAP_DIR_DB=/var/snaps/$DATE

#where to copy the snapshot to
BACKUP_TARGET=/storage/backup

#command to take a snapshot with
SNAP_CMD="btrfs subvolume snapshot -r"

#subvolume snapshot deletion
SNAP_DEL="btrfs subvolume delete"

#command to pack the snapshot with before transferring
PACK_CMD="nice -n 19 tar -zcf"

#copy to backup directory command
COPY_CMD="cp -rf"

#delete some stuff command
DEL_CMD="rm -rf"

#create the backup dir
mkdir $SNAP_DIR_STOR
mkdir $SNAP_DIR_DB
mkdir $BACKUP_TARGET"/"$DATE

#loop through stuff to snapshot
for subvolume in ${SOURCES_STOR[@]}; do
	backup_name=${subvolume##*/}
	$SNAP_CMD $subvolume $SNAP_DIR_STOR"/"$backup_name
	$PACK_CMD $SNAP_DIR_STOR"/"$backup_name".tar.gz" $SNAP_DIR_STOR"/"$backup_name
	$COPY_CMD $SNAP_DIR_STOR"/"$backup_name".tar.gz" $BACKUP_TARGET"/"$DATE"/"
	$SNAP_DEL $SNAP_DIR_STOR"/"$backup_name
done

#loop through stuff to snapshot this time db
for subvolume in ${SOURCES_DB[@]}; do
	backup_name=${subvolume##*/}
	$SNAP_CMD $subvolume $SNAP_DIR_DB"/"$backup_name
	$PACK_CMD $SNAP_DIR_DB"/"$backup_name".tar.gz" $SNAP_DIR_DB"/"$backup_name
	$COPY_CMD $SNAP_DIR_DB"/"$backup_name".tar.gz" $BACKUP_TARGET"/"$DATE"/"
	$SNAP_DEL $SNAP_DIR_DB"/"$backup_name
done


#deleting the local directory
$DEL_CMD $SNAP_DIR_STOR
$DEL_CMD $SNAP_DIR_DB

exit 0
