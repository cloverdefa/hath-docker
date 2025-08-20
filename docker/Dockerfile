# 第一階段
FROM alpine:latest AS download-hath
ARG HATH_VERSION="1.6.4"

RUN apk add --no-cache wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip -d /tmp \
    && rm HentaiAtHome_$HATH_VERSION.zip \
    && [ -f "/tmp/HentaiAtHome.jar" ]

# 第二階段
FROM amazoncorretto:8u462-alpine3.22-jre
LABEL maintainer="cloverdefa <jackie@dast.tw>"

WORKDIR /hath

COPY --from=download-hath /tmp/HentaiAtHome.jar /hath/
COPY /start/run.sh /hath/
RUN chmod +x /hath/run.sh 

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

# 建立Docker Health檢查
HEALTHCHECK --interval=90s --timeout=30s --start-period=60s --retries=3 \
    CMD pgrep -f "java -jar /hath/HentaiAtHome.jar" || exit 1

CMD ["/hath/run.sh"]

