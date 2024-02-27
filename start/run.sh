#!/bin/ash

# 設定錯誤則立即退出
set -e

# 設定適當的 umask
[ "${UMASK:-UNSET}" != "UNSET" ] && umask "$UMASK"

# 檢查並建立缺少的資料夾
[ -d /hath/cache ] || mkdir -p /hath/cache
[ -d /hath/data ] || mkdir -p /hath/data
[ -d /hath/download ] || mkdir -p /hath/download
[ -d /hath/log ] || mkdir -p /hath/log
[ -d /hath/tmp ] || mkdir -p /hath/tmp

# 如果 client_login 檔案不存在，則創建並寫入內容
if [ ! -f /hath/data/client_login ]; then
	printf "${HATH_CLIENT_ID}-${HATH_CLIENT_KEY}" >> /hath/data/client_login
fi

# 設定啟動參數及資料夾路徑
exec java -jar /hath/HentaiAtHome.jar \
    --disable_bwm                     \
    --cache-dir=/hath/cache           \
    --data-dir=/hath/data             \
    --download-dir=/hath/download     \
    --log-dir=/hath/log               \
    --temp-dir=/hath/tmp
