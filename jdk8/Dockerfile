FROM buildpack-deps:jessie-scm

ENV JAVA_VERSION jdk1.8.0_101
ENV JAVA_TARGZ jdk-8u101-linux-x64.tar.gz

RUN set -x \
    && apt-get update --quiet

# Oracle JDK
COPY ${JAVA_TARGZ} ${JAVA_TARGZ}
RUN tar xfz ${JAVA_TARGZ} && mkdir /usr/lib/jvm && mv ${JAVA_VERSION} /usr/lib/jvm/ && rm ${JAVA_TARGZ}

ENV JAVA_HOME /usr/lib/jvm/${JAVA_VERSION}
ENV PATH "$PATH:$JAVA_HOME/bin"

# javac to verify we have a JDK
CMD ["javac", "-version"]