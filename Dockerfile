FROM openjdk:8-jre-alpine
LABEL MAINTAINER=cloverdefa
LABEL VERSION=0.0.9

ARG HATH_VERSION=1.6.1

WORKDIR /opt/hath

COPY start.sh /opt/hath/

RUN apk add --no-cache --update --virtual build-hath wget unzip \
    && wget -O /tmp/hath-$HATH_VERSION.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip /tmp/hath-$HATH_VERSION.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat HentaiAtHomeGUI.jar \
    && rm /tmp/hath-$HATH_VERSION.zip \
    && apk del build-hath

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
