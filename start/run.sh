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

proxy_args=""
[ -n "${PROXY_HOST}" ] && proxy_args="${proxy_args} --image-proxy-host=${PROXY_HOST}"
[ -n "${PROXY_TYPE}" ] && proxy_args="${proxy_args} --image-proxy-type=${PROXY_TYPE}"
[ -n "${PROXY_PORT}" ] && proxy_args="${proxy_args} --image-proxy-port=${PROXY_PORT}"

# 設定啟動參數及資料夾路徑
exec java -jar "/hath/HentaiAtHome.jar" \
  ${proxy_args} \
  --cache-dir="/hath/cache" \
  --data-dir="/hath/data" \
  --download-dir="/hath/download" \
  --log-dir="/hath/log" \
  --temp-dir="/hath/tmp"
