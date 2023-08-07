FROM openjdk:alpine
LABEL MAINTAINER="cloverdefa"

ARG ARCH

RUN apk update && apk add wget unzip && \
    mkdir -p /opt/hath && \
    wget -O /tmp/hath-1.6.1.zip https://repo.e-hentai.org/hath/HentaiAtHome_1.6.1.zip && \
    unzip /tmp/hath-1.6.1.zip -d /opt/hath && \
    rm /opt/hath/autostartgui.bat && \
    rm /opt/hath/HentaiAtHomeGUI.jar && \
    rm /tmp/hath-1.6.1.zip

ADD start.sh /opt/hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

WORKDIR /opt/hath

CMD ["start.sh"]