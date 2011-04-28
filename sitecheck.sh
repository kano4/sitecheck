#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
cd ~/sitecheck
LOCKFILE=tmp/lock.txt
if [ -e $LOCKFILE ]; then
	# ロックファイルが存在。今回は処理しない。
	# でもこのままだとロック起きる可能性あり。
	echo "File exist"
else
	# ロックファイルが存在しない。処理を行う。
#	touch $LOCKFILE
	ruby ./script/runner Site.all_check
#	rm -rf $LOCKFILE
fi
