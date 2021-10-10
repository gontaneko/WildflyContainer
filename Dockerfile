FROM openjdk:18-slim-bullseye

ENV WILDFLY_VERSION 25.0.0
ENV WILDFLY_HOME /opt/wildfly
ENV TMP_WORKDIR /tmp/wildfly
ARG WILDFLY_DIST=https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}.Final/wildfly-${WILDFLY_VERSION}.Final.tar.gz
ARG WILDFLY_USER=admin
ARG WILDFLY_PASSWORD=admin

RUN apt-get update
RUN apt-get install -y curl
WORKDIR ${TMP_WORKDIR}

RUN curl -LkvOf ${WILDFLY_DIST}
RUN tar zxf wildfly-${WILDFLY_VERSION}.Final.tar.gz 
RUN mv wildfly-${WILDFLY_VERSION}.Final ${WILDFLY_HOME}
RUN rm -rf ${TMP_WORKDIR}

RUN ${WILDFLY_HOME}/bin/add-user.sh -u ${WILDFLY_USER} -p ${WILDFLY_PASSWORD}

EXPOSE 8080
EXPOSE 9990

ENTRYPOINT [ "/opt/wildfly/bin/standalone.sh" ]
CMD [ "-b=0.0.0.0","-bmanagement=0.0.0.0" ]
