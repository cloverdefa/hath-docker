# hath-docker
hath-docker
在Docker容器中執行H@H客戶端

H@H客戶端版本 : 1.6.5

### Usage

使用docker來運作容器:
```
docker run \
  --name hath \
  --net host \
  --user ${UID}:${GID} \
  -v /本地cache路徑:/hath/cache \
  -v /本地data路徑:/hath/data \
  -v /本地download路徑:/hath/download \
  -v /本地log路徑:/hath/log \
  -v /本地tmp路徑:/hath/tmp \
  -e HATH_CLIENT_ID=輸入你的HATH_ID \
  -e HATH_CLIENT_KEY=輸入你的HATH_KEY \
  -e UMASK=077 \
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
    ports:
      - "12345:12345" # 修改為HATH設定PORT
    user: "${ID}" # .env內ID:設定UID及GID
    volumes:
      - "./cache:/hath/cache"
      - "./data:/hath/data"
      - "./download:/hath/download"
      - "./log:/hath/log"
      - "./tmp:/hath/tmp"
    environment:
      # 編輯同路徑資料夾下的.env檔案來設定ID及KEY
      HATH_CLIENT_ID: "${HATH_CLIENT_ID}"
      HATH_CLIENT_KEY: "${HATH_CLIENT_KEY}"
      UMASK: "077"
      TZ: "Asia/Taipei" # 設定主機所在時區
    env_file: "./.env"
networks:
  hath-networks:
    name: "hath-networks"
```

建立.env檔案存放ID及KEY

### .env(範例)
```
ID=UID:GID
HATH_CLIENT_ID=ID       # 修改ID為你的 H@H client id
HATH_CLIENT_KEY=KEY     # 修改KEY為你的 H@H client key
```

變更.env檔案權限
```
chmod 600 .env
```

## 執行身份（UID/GID）說明

容器內建有一個 `hath`（uid/gid 1000）使用者，Dockerfile 預設以此身份執行。

**但透過 docker-compose 啟動時，`user: "${ID}"` 會覆蓋這個預設值**，實際執行身份由
`.env` 內的 `ID`（格式 `UID:GID`）決定，與 image 內建的 `hath` 使用者無關。

若你在 `.env` 裡：
- **未設定 `ID`**：實際行為依 docker-compose 版本而異，建議務必明確填寫，不要留空。
- **設定 `ID=1000:1000`**：等同於使用 image 內建的 `hath`。
- **設定其他 UID/GID**（例如對齊 host 上某個既有使用者）：容器內程式會以該身份執行，
  此時**掛載到容器的 volume 目錄擁有者也必須是同一組 UID/GID**（詳見下方「Volume 目錄權限」章節），
  否則會遇到 `Permission denied`。

若不透過 docker-compose、改用 `docker run` 且未加 `--user` 參數，才會真正使用 image 內建的 `hath`。

## Volume 目錄權限

`docker-compose.yml` 範例使用 bind mount（如 `./cache:/hath/cache`）將 host 端目錄
掛載進容器。這些目錄的實際存取權限**取決於 host 端目錄本身的擁有者**，與容器內部設定無關。

啟動前請確保 host 端目錄的擁有者，與 `.env` 內 `ID`（UID:GID）一致，例如：

```bash
mkdir -p cache data download log tmp
sudo chown -R $(grep '^ID=' .env | cut -d= -f2 | tr ':' ' ') cache data download log tmp
```

若擁有者不一致，容器會因為沒有寫入權限而無法啟動，`run.sh` 啟動時會印出對應錯誤提示。

## Docker Hub
https://hub.docker.com/r/cloverdefa/hath

## 貢獻
歡迎提交 Issue 或 Pull Request！請遵循以下步驟：

1. Fork 此專案。
2. 建立一個新分支：
   ```
   git checkout -b feature/你的功能名稱
   ```
3. 提交更改並推送到你的分支：
   ```
   git commit -m "說明你的修改內容"
   git push origin feature/你的功能名稱
   ```
4. 至 GitHub 發送 Pull Request。

## 授權
此專案基於 MIT 授權條款，詳見 [MIT License](https://github.com/cloverdefa/hath-docker/blob/main/LICENSE.md) 授權條款。
