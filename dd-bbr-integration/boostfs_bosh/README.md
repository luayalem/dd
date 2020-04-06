# BoostFS Bosh release

This repository contains a Bosh release for BoostFS.

### Usage

#### Prerequisites
This BoostFS Bosh release requires the following:
  - A deployment of BOSH.
  - DD IP address.
  - DD Storage-Unit.
  - DD BoostFS username.
  - DD BoostFS password.
  - Public IP address for the BoostFS Bosh VM.

#### Upload stemcell
This bosh release uses the latest uploaded version of ubuntu trusty. Stemcells can be downloaded from http://bosh.io/stemcells.

#### Create and Upload a Bosh release
1) upload blobs: 
**For now until we upload the blobs to S3 it is required to upload the blobs manually to the director.**
```
  $ Clone the BoostFS Bosh release repo. git clone https://........
  $ bosh add-blob ~/workspace/boostfs_bosh/blobs/DDBoostFS_1.0.0.5_556666_amd64.deb DDBoostFS_1.0.0.5_556666_amd64.deb
  $ bosh add-blobs ~/workspace/boostfs_bosh/blobs/fuse_2.9.2-4ubuntu4.14.04.1_amd64.deb fuse_2.9.2-4ubuntu4.14.04.1_amd64.deb
```
2) Create a BoostFS Bosh release:
```
  $ cd ~/workspace/boostfs_bosh
  $ bosh create-release
```
3) Upload the release to your bosh environment:
```
  $ bosh -e YOUR-ENV upload-release
```
#### Deployment
This release uses manifest v2 schema. To deploy the release run the following command:
```
  $ bosh -e YOUR-ENV deploy -d boostfs_bosh manifest.yml /
  -v PUBLIC_IP_ADDRESS=Public IP address for the BoostFS Bosh VM /
  -v DDVE_IP=DD IP address /
  -v DDVE_STORAGE-UNIT=DD Storage-Unit /
  -v LOCAL_HOST_MOUNT=The Mount Point Folder to be created on the BoostFS Bosh VM /
  -v DDVE_USER=DD BoostFS username /
  -v DDVE_PASSWORD=DD BoostFS password
```
