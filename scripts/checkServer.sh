#!/bin/bash

DAEMON="/home/ec2-user/PocketMine-MP_alpha"
LOG_FILE="srvChk"
LOG_FILE_EXT="log"
LOG_ARCHIVE="logs"
LOCK_FILE="minecraftPE.Locked"

if ls $DAEMON/Crash* 1> /dev/null 2>&1; then
  now="$(date)"
  DATE=`date +%Y%m%d-%H:%M:%S`
  LOG=$DAEMON/$LOG_ARCHIVE/$LOG_FILE.$DATE.$LOG_FILE_EXT
  echo "Current date and time %s\n" "$now" >> $LOG
  echo "crash log files found" >> $LOG
  /etc/init.d/minecraft stop >>  $LOG
  echo "Removing lock file" >>  $LOG
  rm -f $DAEMON/$LOCK_FILE >>  $LOG
  echo "Restarting server" >>  $LOG
  /etc/init.d/minecraft start >>  $LOG
  rm -f $DAEMON/Crash* >>  $LOG
  echo "Server restarted. Log management." >>  $LOG
  cat  $LOG >> $DAEMON/$LOG_ARCHIVE/$LOG_FILE.$LOG_FILE_EXT
  gzip  $LOG >> $DAEMON/$LOG_ARCHIVE/$LOG_FILE.$LOG_FILE_EXT
  rm -rf $LOG
  echo "Log management complete." >> $DAEMON/$LOG_ARCHIVE/$LOG_FILE.$LOG_FILE_EXT 	
fi
