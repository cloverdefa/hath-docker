#!/usr/bin/env ash
# shellcheck shell=dash

# 確保 HATH_CLIENT_ID 和 HATH_CLIENT_KEY 環境變數已設置
if [ -z "$HATH_CLIENT_ID" ] || [ -z "$HATH_CLIENT_KEY" ]; then
  echo "錯誤：請設置 HATH_CLIENT_ID 和 HATH_CLIENT_KEY 環境變數"
  exit 1
fi

# 設定適當的 umask
[ -n "${UMASK:-}" ] && umask "$UMASK"

# 如果 client_login 檔案不存在，則創建並寫入內容
login_path="/hath/data/client_login"

if [ ! -f "$login_path" ]; then
  echo "${HATH_CLIENT_ID}-${HATH_CLIENT_KEY}" >"$login_path"
fi

# 設定啟動參數及資料夾路徑
exec java -jar "/hath/HentaiAtHome.jar" \
  --image-proxy-host="proxy-host" \
  --image-proxy-type="proxy-type" \
  --image-proxy-port="proxy-port" \
  --cache-dir="/hath/cache" \
  --data-dir="/hath/data" \
  --download-dir="/hath/download" \
  --log-dir="/hath/log" \
  --temp-dir="/hath/tmp"
