#!/usr/bin/env ash
# shellcheck shell=dash

# 設定適當的 umask
[ -n "${UMASK:-}" ] && umask "$UMASK"

# 如果 client_login 檔案不存在，則創建並寫入內容
login_path="/hath/data/client_login"
if [ ! -f "$login_path" ]; then
  echo "${HATH_CLIENT_ID}-${HATH_CLIENT_KEY}" >"$login_path"
fi

# 設定啟動參數及資料夾路徑
exec java -jar "/hath/HentaiAtHome.jar" \
  --cache-dir="/hath/cache" \
  --data-dir="/hath/data" \
  --download-dir="/hath/download" \
  --log-dir="/hath/log" \
  --temp-dir="/hath/tmp"
