#
# Grakn Dockerfile
#
# https://github.com/alexdeleon/grakn-docker
#
FROM java:8

LABEL maintainer="github.com/alexdeleon"

ENV GRAKN_VERSION=1.5.0

ENV GRAKN_HOME=/opt/grakn

RUN mkdir -p $GRAKN_HOME && \
    wget https://github.com/graknlabs/grakn/releases/download/1.5.0/grakn-core-all-linux-${GRAKN_VERSION}.tar.gz && \
    tar xzf grakn-core-all-linux-${GRAKN_VERSION}.tar.gz && cp -Rf grakn-core-all-linux-${GRAKN_VERSION}/* $GRAKN_HOME

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
