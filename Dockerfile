FROM openjdk:22-slim-bookworm
LABEL MAINTAINER="cloverdefa"

RUN apt-get update && apt-get upgrade -y \
    && apt install -y wget unzip curl \
    && mkdir -p /opt/hath \
    && wget -O /tmp/hath-1.6.1.zip \
    https://repo.e-hentai.org/hath/HentaiAtHome_1.6.1.zip \
    && unzip /tmp/hath-1.6.1.zip -d /opt/hath \
    && rm /opt/hath/autostartgui.bat \
    && rm /opt/hath/HentaiAtHomeGUI.jar \
    && rm /tmp/hath-1.6.1.zip

ADD src/* /opt/hath/

HEALTHCHECK --interval=60s --start-period=180s --timeout=60s --retries=3 \
  CMD curl -fs http://e-hentai.org || exit 1

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]