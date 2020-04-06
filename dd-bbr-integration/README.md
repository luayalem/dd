# BBR Automation Script 

This script automates the PCF Bosh Backup procedure for the CNDP environment.

It collects performance statistics for the same backup being executed on a VM filesystem as well as a BoostFS mountpoint.

### Getting Started

#### Installing backup_bbr.sh

Install the script by pulling it from giit

Example:

     $ git clone git@durgitswarm1.cec.lab.emc.com:CNDP/dd-bbr-integration.git
     
     
#### Using bosh_bbr.sh

Update the following fields in backup_bbr.sh for your deployment:
    export BOSH_CLIENT_SECRET=v51N-hfSFTdVHh9uAxNDheR_6D3BTE3P
    export PRIVATE_KEY=/bin/bbr/bbr_key
    export DIRECTOR_IP=10.0.0.10
    export ERT_USERNAME=bbr_client
    export BOSH_USERNAME=bbr
    export DEPLOYMENT_NAME=cf-e6b6ade56b8a6e34b0e7
    export BOSH_SERVER_CERT=/bin/bbr/bbr_root_cert
    export LOG_FILE=backup_log_$(date +%F_%H_%M)

Execute by typing ./backup_bbr.sh

Example output:

     running pre-backup-check
    [bbr] 2017/07/26 18:42:07 INFO - Running pre-checks for backup of cf-e6b6ade56b8a6e34b0e7...
    [bbr] 2017/07/26 18:42:07 INFO - Scripts found:
    [bbr] 2017/07/26 18:42:09 INFO - backup-prepare/01841cca-1a69-4409-8645-50382d96ee94/pull-back/backup
    [bbr] 2017/07/26 18:42:09 INFO - backup-prepare/01841cca-1a69-4409-8645-50382d96ee94/mysql-backup/metadata
    [bbr] 2017/07/26 18:42:10 INFO - uaa/d3e446a0-fe92-4aa6-a55c-afd1a627581e/uaa/backup
...
    Deployment ‘cf-e6b6ade56b8a6e34b0e7’ can be backed up.
    [bbr] 2017/07/26 18:42:41 INFO - Running pre-checks for backup of cf-e6b6ade56b8a6e34b0e7...
    [bbr] 2017/07/26 18:42:41 INFO - Scripts found:
    [bbr] 2017/07/26 18:42:45 INFO - uaa/d3e446a0-fe92-4aa6-a55c-afd1a627581e/uaa/backup
    [bbr] 2017/07/26 18:42:45 INFO - uaa/d3e446a0-fe92-4aa6-a55c-afd1a627581e/uaa/restore
    [bbr] 2017/07/26 18:42:45 INFO - uaa/92f77007-24d7-4ff5-a0e7-aa30b47b69cd/uaa/backup    
    [bbr] 2017/07/26 18:42:45 INFO - uaa/92f77007-24d7-4ff5-a0e7-aa30b47b69cd/uaa/restore
    [bbr] 2017/07/26 18:42:47 INFO - cloud_controller/cf398cd7-5e6b-4c51-93f4-aa81e380433f/cloud-controller-backup/post-backup-unlock
...
    [bbr] 2017/07/26 18:43:02 INFO - nfs_server/e19d14ef-9614-42af-b128-62fb70db927a/blobstore-backup/restore
    [bbr] 2017/07/26 18:43:07 INFO - Starting backup of cf-e6b6ade56b8a6e34b0e7...
    [bbr] 2017/07/26 18:43:07 INFO - Running pre-backup scripts...
    [bbr] 2017/07/26 18:43:07 INFO - Locking cloud-controller-backup on cloud_controller/cf398cd7-5e6b-4c51-93f4-aa81e380433f for backup...
    [bbr] 2017/07/26 18:43:19 INFO - Done.
    [bbr] 2017/07/26 18:43:19 INFO - Locking cloud-controller-backup on cloud_controller/98ab0e5c-7fac-41d9-b861-30fe390e2b21 for backup...
...
    [bbr] 2017/07/26 18:57:24 INFO - Starting validity checks
    [bbr] 2017/07/26 18:57:24 INFO - Finished validity checks
    [bbr] 2017/07/26 18:57:24 INFO - Copying backup -- 208M uncompressed -- from backup-prepare/01841cca-1a69-4409-8645-50382d96ee94...
    [bbr] 2017/07/26 18:57:27 INFO - Finished copying backup -- from backup-prepare/01841cca-1a69-4409-8645-50382d96ee94...
    [bbr] 2017/07/26 18:57:27 INFO - Starting validity checks
    [bbr] 2017/07/26 18:57:30 INFO - Finished validity checks
    [bbr] 2017/07/26 18:57:30 INFO - Copying backup -- 3.7G uncompressed -- from nfs_server/e19d14ef-9614-42af-b128-62fb70db927a...
    [bbr] 2017/07/26 19:00:30 INFO - Finished copying backup -- from nfs_server/e19d14ef-9614-42af-b128-62fb70db927a...
    [bbr] 2017/07/26 19:00:30 INFO - Starting validity checks
    [bbr] 2017/07/26 19:04:16 INFO - Finished validity checks
    [bbr] 2017/07/26 19:04:16 INFO - Backup created of cf-e6b6ade56b8a6e34b0e7 on 2017-07-26 19:04:16.230439773 +0000 UTC
running BOSH Director backup
    [bbr] 2017/07/26 19:04:22 INFO - Running pre-checks for backup of 10.0.0.10...
    [bbr] 2017/07/26 19:04:22 INFO - Scripts found:
    [bbr] 2017/07/26 19:04:22 INFO - bosh/blobstore/backup
    [bbr] 2017/07/26 19:04:22 INFO - bosh/blobstore/restore
    [bbr] 2017/07/26 19:04:22 INFO - bosh/credhub/backup
...
    [] 2017/07/26 19:44:43 INFO - Cleaning up...
    It took 33 seconds to perform pre check
    It took 1302 seconds to perform ERT backup
    It took 2421 seconds to perform BOSH director backup
    It took 3756 seconds to perform full backup
    It took 1546 seconds to copy backed up files off the jumpbox
    4038012 cf-e6b6ade56b8a6e34b0e7_20170726T184307Z
    11286136    10.0.0.10_20170726T190422Z