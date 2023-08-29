#!/bin/bash

# This script is the same as sync-war-s3.sh, but allows a second parameter to be
# provieded in the case that the target directory is different from the version
# ID. For example, a patch build like, 2.31.1, might be sent to
# <releases>/2.31/2.31.1/ instead of <releases>/2.31.1/

WAR_LOCATION="/ebs1/jenkins/workspace/dataorb-$1/dataorb/dlms-web/dlms-web-portal/target/dlms.war"
S3_LOCATION="s3://releases.dataorb.co/$2/dlms.war"

if [ ! -d /ebs1/jenkins/workspace/dataorb-$1 ]; then
  echo "No job with name dataorb-$1 exists."
  exit 1
fi

# Copy WAR file to S3
aws s3 cp $WAR_LOCATION $S3_LOCATION
