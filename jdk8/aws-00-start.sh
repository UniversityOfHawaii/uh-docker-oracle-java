#!/bin/bash
if [ -z "$1" ]; then
    echo "Required arguements not set, read this script."
    exit
fi
AWSIP=$1

AWSUSER=ec2-user
SSHID="$HOME/.ssh/em21_itses_id_rsa.pem"

JAVA_TARGZ=$(grep "ENV JAVA_TARGZ" Dockerfile | cut -d' ' -f 3)
JAVA_VERSION=$(grep "ENV JAVA_VERSION" Dockerfile | cut -d' ' -f 3)

if [ ! -f "$JAVA_TARGZ" ]; then
	echo "Expecting $JAVA_TARGZ to be in this directory."
	echo "Download from http://www.oracle.com/technetwork/java/javase/downloads/index.html"
	exit
fi

rsync -avz -e "ssh -i \"$SSHID\"" $JAVA_TARGZ $AWSUSER@$AWSIP:
scp -i $SSHID Dockerfile $AWSUSER@$AWSIP:
scp -i $SSHID ../common/aws-*.sh $AWSUSER@$AWSIP:

ssh -i $SSHID -l $AWSUSER $AWSIP ./aws-01-keys.sh
ssh -i $SSHID -l $AWSUSER $AWSIP ./aws-02a-docker-install.sh
ssh -i $SSHID -l $AWSUSER $AWSIP ./aws-03z-docker-build.sh

echo "downloading docker saved image of $JAVA_VERSION"
scp -i $SSHID $AWSUSER@$AWSIP:$JAVA_VERSION.tar .
