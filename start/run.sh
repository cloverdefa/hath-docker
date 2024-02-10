#!/bin/ash
set -e

# 設定適當的 umask
[ "${UMASK:-UNSET}" != "UNSET" ] && umask "$UMASK"

# 如果 client_login 檔案不存在，則創建並寫入內容
[ ! -f /hath/data/client_login ] && {
    printf "%s-%s" "${HATH_CLIENT_ID}" "${HATH_CLIENT_KEY}" > /hath/data/client_login
}

# 建立Docker Health檢查
HEALTHCHECK --interval=90s --timeout=30s --start-period=60s --retries=3 \
    CMD pgrep -f "java -jar /hath/HentaiAtHome.jar" || exit 1

# 設定資料夾路徑
exec java -jar /hath/HentaiAtHome.jar --disable_bwm \
    --cache-dir=/hath/cache               \
    --data-dir=/hath/data                 \
    --download-dir=/hath/download         \
    --log-dir=/hath/log                   \
    --temp-dir=/hath/tmp
