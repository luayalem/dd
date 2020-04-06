#!/usr/bin/env bash

export BOSH_CLIENT_SECRET=v51N-hfSFTdVHh9uAxNDheR_6D3BTE3P
export PRIVATE_KEY=/bin/bbr/bbr_key
export DIRECTOR_IP=10.0.0.10
export ERT_USERNAME=bbr_client
export BOSH_USERNAME=bbr
export DEPLOYMENT_NAME=cf-e6b6ade56b8a6e34b0e7
export BOSH_SERVER_CERT=/bin/bbr/bbr_root_cert
export LOG_FILE=backup_log_$(date +%F_%H_%M)

if pwd==/home/ubuntu/local_backup
then
    rm -rf cf*
    rm -rf 10*
fi
STARTBT=$(date +%s)

echo "running pre-backup-check" > $LOG_FILE

STARTPHASE=$(date +%s)

BOSH_CLIENT_SECRET=$BOSH_CLIENT_SECRET bbr deployment --target $DIRECTOR_IP --username $ERT_USERNAME --deployment $DEPLOYMENT_NAME --ca-cert $BOSH_SERVER_CERT pre-backup-check >> $LOG_FILE

ENDPHASE=$(date +%s)
DIFFPRE=$[$ENDPHASE - $STARTPHASE]

if [ $?==0 ] 
then
    STARTPHASE=$(date +%s)
    echo "running ERT backup" >> $LOG_FILE
    BOSH_CLIENT_SECRET=$BOSH_CLIENT_SECRET bbr deployment --target $DIRECTOR_IP --username $ERT_USERNAME --deployment $DEPLOYMENT_NAME --ca-cert $BOSH_SERVER_CERT backup >> $LOG_FILE
    ENDPHASE=$(date +%s)
    DIFFERT=$[$ENDPHASE - $STARTPHASE]
   if [ $?==0 ]
   then
       STARTPHASE=$(date +%s)
       echo "running BOSH Director backup" >> $LOG_FILE
       bbr director --private-key-path $PRIVATE_KEY --username $BOSH_USERNAME --host $DIRECTOR_IP backup >> $LOG_FILE
       ENDPHASE=$(date +%s)
       DIFFDIRBOSH=$[$ENDPHASE - $STARTPHASE]
   else
      echo "ERT backup failed" >> $LOG_FILE
   fi
else 
   echo "pre-backup-check failed" >> $LOG_FILE
fi

DIFFBT=$[$ENDPHASE - $STARTBT]


STARTCT=$(date +%s)
scp -rf cf-* cndpuser@40.71.101.137:/bbr_backup_files >> $LOG_FILE
scp -rf 10* cndpuser@40.71.101.137:/bbr_backup_files >> $LOG_FILE
ENDCT=$(date +%s)
DIFFCT=$[$ENDCT - $STARTCT]
ssh cndpuser@40.71.101.137 rm -rf /home/cndpuser/bbr_backup_files/*

echo "It took $DIFFPRE seconds to perform pre check" >> $LOG_FILE
echo "It took $DIFFERT seconds to perform ERT backup" >> $LOG_FILE
echo "It took $DIFFDIRBOSH seconds to perform BOSH director backup" >> $LOG_FILE
echo "It took $DIFFBT seconds to perform full backup" >> $LOG_FILE
echo "It took $DIFFCT seconds to copy backed up files off the jumpbox" >> $LOG_FILE
du -s cf* >> $LOG_FILE
du -s 10* >> $LOG_FILE
