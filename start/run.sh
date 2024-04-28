#!/usr/bin/env ash

# 設定錯誤則立即退出
set -e

# 設定適當的 umask
[ "${UMASK:-UNSET}" != "UNSET" ] && umask "$UMASK"

# 如果 client_login 檔案不存在，則創建並寫入內容
if [ ! -f /hath/data/client_login ]; then
	printf "${HATH_CLIENT_ID}-${HATH_CLIENT_KEY}" >> /hath/data/client_login
fi

# 設定啟動參數及資料夾路徑
exec java -jar /hath/HentaiAtHome.jar \
    --cache-dir=/hath/cache           \
    --data-dir=/hath/data             \
    --download-dir=/hath/download     \
    --log-dir=/hath/log               \
    --temp-dir=/hath/tmp
