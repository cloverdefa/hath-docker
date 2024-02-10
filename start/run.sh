#!/bin/ash

# 設定適當的 umask
if [ "${UMASK:-UNSET}" != "UNSET" ]; then
  umask "$UMASK"
fi

# 創建 client_login，如果尚不存在
if [ ! -f /hath/data/client_login ]; then
	printf "${HATH_CLIENT_ID}-${HATH_CLIENT_KEY}" >> /hath/data/client_login
fi

# 建立Docker Heath檢查
HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD ps ax |grep "HentaiAtHome"||exit

# 設定資料夾路徑
exec java -jar /hath/HentaiAtHome.jar --disable_bwm \
    --cache-dir=/hath/cache               \
    --data-dir=/hath/data                 \
    --download-dir=/hath/download         \
    --log-dir=/hath/log                   \
    --temp-dir=/hath/tmp
