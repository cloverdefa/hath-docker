# 第一階段
FROM alpine:latest AS download-hath
ARG HATH_VERSION="1.6.2"

RUN apk add --no-cache wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip -d /tmp

# 第二階段
FROM amazoncorretto:8u392-alpine3.18-jre
LABEL MAINTAINER="cloverdefa"

RUN mkdir /hath

COPY --from=download-hath /tmp/HentaiAtHome.jar /hath/
COPY /start/run.sh /hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/hath/run.sh"]
