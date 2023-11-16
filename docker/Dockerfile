FROM alpine:latest AS get-hath
ARG HATH_VERSION=1.6.2

RUN apk add wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip

FROM amazoncorretto:latest
LABEL MAINTAINER="cloverdefa"

RUN mkdir /opt/hath \
    && mkdir /hath

COPY --from=get-hath ./HentaiAtHome.jar /opt/hath/
COPY /RUN/run.sh /opt/hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/run.sh"]
