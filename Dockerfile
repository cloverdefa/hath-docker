FROM alpine:latest AS get-hath

ARG HATH_VERSION=1.6.2

WORKDIR /app

RUN apk add wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip

FROM amazoncorretto:latest

LABEL MAINTAINER="cloverdefa"

WORKDIR /opt/hath

COPY --from=get-hath /app/HentaiAtHome.jar /opt/hath/

COPY start.sh /opt/hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
