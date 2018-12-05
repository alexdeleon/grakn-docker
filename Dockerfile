#
# Grakn Dockerfile
#
# https://github.com/alexdeleon/grakn-docker
#
FROM java:8

LABEL maintainer="github.com/alexdeleon"

ARG GRAKN_VERSION=1.4.2

ENV GRAKN_HOME=/opt/grakn

RUN mkdir -p $GRAKN_HOME && \
    wget https://github.com/graknlabs/grakn/releases/download/v${GRAKN_VERSION}/grakn-core-${GRAKN_VERSION}.zip && \
    unzip grakn-core-${GRAKN_VERSION}.zip -d $GRAKN_HOME && cp -Rf $GRAKN_HOME/grakn-core-${GRAKN_VERSION}/* $GRAKN_HOME

ENV PATH=$PATH:$GRAKN_HOME
WORKDIR $GRAKN_HOME

#COPY cassandra.yaml $GRAKN_HOME/services/cassandra
COPY grakn-docker-entrypoint /usr/local/bin

# Grakn Server
EXPOSE 4567
# Thrift client API
EXPOSE 9160
# Grakn gRPC
EXPOSE 48555

ENTRYPOINT [ "grakn-docker-entrypoint" ]
