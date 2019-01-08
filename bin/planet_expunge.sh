#!/bin/bash
#
# Expunge the cache of planets (to be run each week by cron)

PLANETS=`find /home/venus/lang/ -regex ".*planet_.*.ini$" | grep -v XX`

for i in $PLANETS ; do
  planet -x $i
done
