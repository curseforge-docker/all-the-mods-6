FROM amazoncorretto:8

ARG VERSION
ENV VERION=$VERSION

WORKDIR /minecraft
COPY eulacheck.sh .
COPY versions/$VERSION/server-setup-config.yaml .
COPY versions/$VERSION/startserver.sh .

VOLUME /minecraft

RUN yum install -y which wget

ENTRYPOINT ["/bin/sh", "-c", "./eulacheck.sh && ./startserver.sh"]
