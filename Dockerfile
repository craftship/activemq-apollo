FROM ubuntu:16.04

MAINTAINER Craftship Ltd "hello@craftship.io"

ENV APOLLO_VERSION 1.7.1
ENV APOLLO_BROKER_HOME /var/lib
ENV APOLLO_BROKER_ID mybroker

RUN apt-get update -y
RUN apt-get install curl default-jre -y

RUN curl http://apache.mirror.anlx.net/activemq/activemq-apollo/$APOLLO_VERSION/apache-apollo-$APOLLO_VERSION-unix-distro.tar.gz -o /tmp/apache-apollo-$APOLLO_VERSION-unix-distro.tar.gz \
  && tar -zxvf /tmp/apache-apollo-$APOLLO_VERSION-unix-distro.tar.gz -C /opt \
  && rm -f /tmp/apache-apollo-$APOLLO_VERSION-unix-distro.tar.gz \
  && cd /var/lib \
  && /opt/apache-apollo-$APOLLO_VERSION/bin/apollo create $APOLLO_BROKER_ID

ADD ./etc /var/lib/$APOLLO_BROKER_ID/etc

WORKDIR /var/lib/$APOLLO_BROKER_ID

EXPOSE 61680 61681 61613

ENTRYPOINT ["bin/apollo-broker", "run"]
