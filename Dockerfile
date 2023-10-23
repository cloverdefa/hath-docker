FROM amazoncorretto:8u392-alpine3.18-jre
LABEL MAINTAINER="cloverdefa"

ARG HATH_VERSION

WORKDIR /opt/hath

RUN apk add --no-cache --update --virtual build-hath wget unzip \
    && wget -O /tmp/hath-$HATH_VERSION.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip /tmp/hath-$HATH_VERSION.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat HentaiAtHomeGUI.jar \
    && rm /tmp/hath-$HATH_VERSION.zip \
    && apk del build-hath

ADD start.sh /opt/hath/

HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD pgrep java|grep "1"||exit

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
