#!/bin/ash
set -e

# 設定適當的 umask
[ "${UMASK:-UNSET}" != "UNSET" ] && umask "$UMASK"

# 確保目錄存在
mkdir -p /hath/cache /hath/data /hath/download /hath/log /hath/tmp

# 創建 client_login，如果尚不存在
[ ! -f /hath/data/client_login ] && printf "%s-%s" "${HATH_CLIENT_ID}" "${HATH_CLIENT_KEY}" >> /hath/data/client_login

# 建立Docker Health檢查
HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 \
    CMD ps -l|grep "HentaiAtHome"||exit

# 設定資料夾路徑
exec java -jar /hath/HentaiAtHome.jar --disable_bwm \
    --cache-dir=/hath/cache               \
    --data-dir=/hath/data                 \
    --download-dir=/hath/download         \
    --log-dir=/hath/log                   \
    --temp-dir=/hath/tmp
