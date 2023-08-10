FROM openjdk:22-slim-bookworm
LABEL MAINTAINER=cloverdefa
LABEL version=0.0.7-beta

WORKDIR /opt/hath

ARG HATH_VERSION=1.6.1

RUN apt-get update && apt-get upgrade -y \
    && apt install -y wget unzip \
    && wget -O /tmp/hath-${HATH_VERSION}.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_${HATH_VERSION}.zip \
    && unzip /tmp/hath-${HATH_VERSION}.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat \
    && rm /opt/hath/HentaiAtHomeGUI.jar \
    && rm /tmp/hath-${HATH_VERSION}.zip

ADD src/* /opt/hath/

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD jstack 1|grep 'HentaiAtHome'||exit

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
