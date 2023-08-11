FROM openjdk:8-jdk-alpine
LABEL MAINTAINER=cloverdefa
LABEL VERSION=0.0.8-beta

RUN apk add --no-cache --update \
    ca-certificates \
    tzdata \
 && update-ca-certificates

ARG HATH_VERSION=1.6.1

WORKDIR /opt/hath

ADD src/* /opt/hath/

RUN apk add --no-cache --update --virtual build-hath wget unzip \
    && wget -O /tmp/hath-$HATH_VERSION.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_${HATH_VERSION}.zip \
    && unzip /tmp/HentaiAtHome_${HATH_VERSION}.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat HentaiAtHomeGUI.jar \
    && rm /tmp/HentaiAtHome_${HATH_VERSION}.zip \
    && apk del build-hath

HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD jstack 1|grep 'HentaiAtHome'||exit

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
