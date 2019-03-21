#
# Grakn Dockerfile
#
# https://github.com/alexdeleon/grakn-docker
#
FROM java:8

LABEL maintainer="github.com/alexdeleon"

ARG GRAKN_VERSION=1.5.0

ENV GRAKN_HOME=/opt/grakn

COPY grakn-core-all-1.5.0.zip .

RUN mkdir -p $GRAKN_HOME && \
    unzip grakn-core-all-1.5.0.zip -d $GRAKN_HOME && cp -Rf $GRAKN_HOME/grakn-core-all/* $GRAKN_HOME

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
