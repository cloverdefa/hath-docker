# 第一階段
FROM alpine:3.24 AS download-hath
ARG HATH_VERSION="1.6.5"
RUN apk add --no-cache wget unzip \
    && wget https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip \
    && unzip HentaiAtHome_$HATH_VERSION.zip -d /tmp \
    && rm HentaiAtHome_$HATH_VERSION.zip \
    && [ -f "/tmp/HentaiAtHome.jar" ]

# 第二階段
FROM amazoncorretto:8-alpine3.24-jre
ARG IMAGE_VERSION="0.5.9"
LABEL maintainer="cloverdefa <jackie@dast.tw>"
LABEL version="${IMAGE_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/cloverdefa/hath-docker"

RUN addgroup -g 1000 hath && adduser -D -u 1000 -G hath hath

WORKDIR /hath
COPY --from=download-hath --chown=hath:hath --chmod=644 /tmp/HentaiAtHome.jar /hath/
COPY --chown=hath:hath --chmod=755 start/run.sh /hath/

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]
USER hath
STOPSIGNAL SIGTERM

HEALTHCHECK --interval=90s --timeout=30s --start-period=60s --retries=3 \
    CMD pgrep -f "java -jar /hath/HentaiAtHome.jar" || exit 1
CMD ["/hath/run.sh"]
