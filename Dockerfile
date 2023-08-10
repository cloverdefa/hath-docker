FROM openjdk:22-slim-bookworm
LABEL MAINTAINER=cloverdefa
LABEL version=0.0.7

ARG HATH_VERSION=1.6.1

WORKDIR /opt/hath

ADD src/* /opt/hath/
ADD https://repo.e-hentai.org/hath/HentaiAtHome_${HATH_VERSION}.zip \
    /opt/hath

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y unzip \
    && unzip /opt/hath/HentaiAtHome_${HATH_VERSION}.zip \
    && rm /opt/hath/autostartgui.bat \
    && rm /opt/hath/HentaiAtHomeGUI.jar \
    && rm /opt/hath/HentaiAtHome_${HATH_VERSION}.zip

HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD jstack 1|grep 'HentaiAtHome'||exit

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
