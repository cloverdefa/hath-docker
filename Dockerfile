FROM openjdk:alpine
LABEL MAINTAINER="cloverdefa"

RUN apk update && apk upgrade \
    && apk add wget unzip \
    && mkdir -p /opt/hath \
    && wget -O /tmp/hath-1.6.1.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_1.6.1.zip \
    && unzip /tmp/hath-1.6.1.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat \
    && rm /opt/hath/HentaiAtHomeGUI.jar \
    && rm /tmp/hath-1.6.1.zip

ADD src/* /opt/hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]