# hath-docker

hath-docker

在Docker容器中執行H@H客戶端

版本 :  
H@H客戶端版本 : 1.6.4

### Usage

使用docker來運作容器:

```
docker run \
--name hath \
--net host \
--user ${UID}:${GID} \
--image-proxy-host=<host> \  # 非必要選項 proxy hostname or IP
--image-proxy-type=<type> \  # 非必要選項 Proxy類型 "socks" 或 "http". 空白則使用預設 "socks"
--image-proxy-port=<port> \  # 非必要選項 Proxy Port 空白則使用預設為 SOCKS 1080 ，HTTP 8080
-v /本地cache路徑:/hath/cache \
-v /本地data路徑:/hath/data \
-v /本地download路徑:/hath/download \
-v /本地log路徑:/hath/log \
-v /本地tmp路徑:/hath/tmp \
-e HATH_CLIENT_ID=輸入你的HATH ID \
-e HATH_CLIENT_KEY=輸入你的HATH KEY \
-e UMASK=000 \
cloverdefa/hath:latest
```

使用docker-compose來運作容器:

### docker-compose.yml範例

```
---
services:
  hath:
    container_name: "hath"
    image: "cloverdefa/hath:latest"
    restart: "unless-stopped"
    networks:
      - "hath-networks"
    prots:
      - "12345:12345" # 修改為HATH設定PORT
    user: "${ID}" # .env內ID:設定UID及GID
    volumes:
      - "./cache:/hath/cache"
      - "./data:/hath/data"
      - "./download:/hath/download"
      - "./log:/hath/log"
      - "./tmp:/hath/tmp"
    environment:
      PROXY_HOST: "111.222.333.444"   # 非必要選項 proxy hostname or IP
      PROXY_TYPE: "socks"             # 非必要選項 Proxy 類型 "socks" 或 "http". 空白則使用預設 "socks"
      PROXY_PORT: "1080"              # 非必要選項 Proxy Port，空白則預設 SOCKS 為 1080，HTTP 為 8080
      # 編輯同路徑資料夾下的.env檔案來設定ID及KEY
      HATH_CLIENT_ID: "${HATH_CLIENT_ID}"
      HATH_CLIENT_KEY: "${HATH_CLIENT_KEY}"
      UMASK: "000"
      TZ: "Asia/Taipei" # 設定主機所在時區
    env_file: "./.env"

networks:
  hath-networks:
    name: "hath-networks"
```

建立.env檔案存放ID及KEY

### .env(範例)

```
ID: "UID:GID"
HATH_CLIENT_ID: "ID"    #  修改ID為你的 H@H client id
HATH_CLIENT_KEY: ‘KEY’    #  修改KEY為你的 H@H client key
```

變更.env檔案權限  
chmod 600 .env

## Docker Hub

https://hub.docker.com/r/cloverdefa/hath

## 貢獻

歡迎提交 Issue 或 Pull Request！請遵循以下步驟：

## Fork 此專案。

創建一個新分支：
提交更改並推送到你的分支。
發送 Pull Request。
授權
此專案基於 MIT 授權條款，詳見[MIT License](https://github.com/cloverdefa/hath-docker/blob/main/LICENSE.md) 授權條款。
