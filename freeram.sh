#!/bin/bash
# frees up ram
modprobe nfsd cltrack_legacy_disable=1 nfs4_disable_idmapping=1
modprobe nfs max_session_slots=2 nfs4_disable_idmapping=1
service nfs-kernel-server stop && swapoff -a && swapon -a && service zram-config restart && service nfs-kernel-server start
exit 0
