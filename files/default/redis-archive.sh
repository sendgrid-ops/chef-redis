#!/bin/bash

################################################################################
# redis-archive.sh                                                             #
################################################################################
# Archive all redis databases to /var/lib/redis-archive every night. On Sunday,
# create a weekly copy of the data. We store up to 5 copies of the
# weekly backups.
################################################################################

# make sure our target directory is available
mkdir -p /var/lib/redis-archive/

DATE=`date +'%Y%m%d'`   # YYYYMMDD
DOW=`date +'%w'`        # day of week
WOY=`date +'%W'`        # week of year
DATE=`date +'%d'`       # day of month
WEEKNUM=$(($WOY%5))     # the week that we are backing up
                        # beauty of this is that this number rotates
                        # 0-4 so you do not need to do any manual deletes
                        # of old backups

# randomly sleep between now and 1800 seconds (30 minutes) from now
#sleep $[ ( $RANDOM % 1800 )  + 1 ]s

# do our dump to the /tmp folder so we don't mess up any backups in place
cp /var/lib/redis/dump.rdb /tmp/redis.rdb.${DOW}

# now replace the existing backup file with mv, this is atomic
# (assuming /tmp and /var/lib/redis-archive are on the same partition)
mv /tmp/redis.rdb.${DOW} /var/lib/redis-archive/redis.rdb.${DOW}

# now, if this is a Sunday, take the backup we just made, and make it a weekly
if [[ ${DOW} == 0 ]]; then
        cp /var/lib/redis-archive/redis.rdb.${DOW} /var/lib/redis-archive/redis.rdb.${WEEKNUM}
fi

/usr/bin/s3cmd sync /var/lib/redis-archive/ s3://sendgrid-ops/$(hostname --fqdn)/redis-archive/