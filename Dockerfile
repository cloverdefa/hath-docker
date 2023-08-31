FROM eclipse-temurin:8u382-b05-jre-jammy
LABEL MAINTAINER="cloverdefa"
LABEL VERSION="0.1.6"

ARG HATH_VERSION=1.6.1

WORKDIR /opt/hath

ADD start.sh /opt/hath/

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install wget unzip -y \
    && wget -O /tmp/hath-$HATH_VERSION.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip /tmp/hath-$HATH_VERSION.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat HentaiAtHomeGUI.jar \
    && rm /tmp/hath-$HATH_VERSION.zip \
    && apt-get remove wget unzip -y

HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD pgrep java|grep "1"||exit

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
