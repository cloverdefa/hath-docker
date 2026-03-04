#!/bin/ash
set -eu

# 檢查必要環境變數
if [ -z "${HATH_CLIENT_ID:-}" ] || [ -z "${HATH_CLIENT_KEY:-}" ]; then
  echo "錯誤：請設置 HATH_CLIENT_ID 和 HATH_CLIENT_KEY 環境變數"
  exit 1
fi

# 設定 UMASK（若有）
case "${UMASK:-}" in
'') ;;
[0-7][0-7][0-7]) umask "$UMASK" ;;
*)
  echo "錯誤：UMASK 格式錯誤"
  exit 1
  ;;
esac

# 確保資料夾存在
for dir in cache data download log tmp; do
  mkdir -p "/hath/$dir"
done

login_path="/hath/data/client_login"

# 若不存在則建立
if [ ! -f "$login_path" ]; then
  umask 077
  printf '%s-%s\n' "$HATH_CLIENT_ID" "$HATH_CLIENT_KEY" >"$login_path"
  chmod 600 "$login_path"
fi

# 使用安全方式組合 proxy 參數
set --

[ -n "${PROXY_HOST:-}" ] && set -- "$@" "--image-proxy-host=$PROXY_HOST"
[ -n "${PROXY_TYPE:-}" ] && set -- "$@" "--image-proxy-type=$PROXY_TYPE"
[ -n "${PROXY_PORT:-}" ] && set -- "$@" "--image-proxy-port=$PROXY_PORT"

exec java -jar "/hath/HentaiAtHome.jar" \
  "$@" \
  --cache-dir="/hath/cache" \
  --data-dir="/hath/data" \
  --download-dir="/hath/download" \
  --log-dir="/hath/log" \
  --temp-dir="/hath/tmp"
