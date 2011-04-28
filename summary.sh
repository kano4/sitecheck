#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
cd ~/sitecheck
ruby ./script/runner Site.send_summary
