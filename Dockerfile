FROM alpine:latest AS build-hath

ARG HATH_VERSION=1.6.2
WORKDIR /app

RUN apk add wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip \
    && rm autostartgui.bat HentaiAtHomeGUI.jar \
    && rm HentaiAtHome_$HATH_VERSION.zip

COPY . ./

FROM amazoncorretto:latest
LABEL MAINTAINER="cloverdefa"

ARG HATH_VERSION

WORKDIR /opt/hath

COPY --from=build-hath /app/HentaiAtHome.jar /opt/hath/

ADD start.sh /opt/hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
