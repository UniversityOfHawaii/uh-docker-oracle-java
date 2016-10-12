#!/bin/bash
JAVA_VERSION=$(grep "ENV JAVA_VERSION" Dockerfile | cut -d' ' -f 3)
docker build -t uh/java:$JAVA_VERSION .
#docker run -v /etc/localtime:/etc/localtime:ro -p 8080:8080 -p 8090:8090 -p 8443:8443 INSTANCE java -version
docker run uh/java:$JAVA_VERSION
echo "saving docker image of uh/java:$JAVA_VERSION to $JAVA_VERSION.tar"
docker save uh/java:$JAVA_VERSION > $JAVA_VERSION.tar 
