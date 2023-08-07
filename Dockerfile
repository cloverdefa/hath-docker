FROM openjdk:alpine
LABEL MAINTAINER cloverdefa

RUN apk update && apk add wget unzip -y && \
    mkdir -p /opt/hath && \
    wget -O /tmp/hath-1.6.1.zip https://repo.e-hentai.org/hath/HentaiAtHome_1.6.1.zip && \
    unzip /tmp/hath-1.6.1.zip -d /opt/hath && rm /tmp/hath-1.6.1.zip

ADD run/start.sh /opt/hath/start.sh

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]