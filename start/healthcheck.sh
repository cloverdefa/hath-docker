#!/bin/sh
# healthcheck.sh
set -e

# 1. process 是否存在
pgrep -f "HentaiAtHome.jar" >/dev/null || exit 1

# 2. 是否有任何 TCP port 處於 LISTEN 狀態
#    (容器內只有 H@H 會開 port，所以這個判斷等同於確認 H@H 真的在服務)
netstat -tln 2>/dev/null | grep -q LISTEN || exit 1

exit 0
