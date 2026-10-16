# hath-docker

以 Docker 執行 [Hentai@Home (H@H)](https://hentaiathome.net/) 客戶端。映像會從官方來源取得 H@H Java 客戶端，並以 Java 8 執行。H@H 客戶端版本目前由 `docker/Dockerfile` 中的 `HATH_VERSION` 指定。

## 快速開始（Docker Compose）

編輯 `example/.env`，填入 H@H 帳號資料。請勿提交含有真實憑證的檔案，並限制檔案權限：

```sh
cd example
chmod 600 .env
```

接著建立資料目錄並設定其擁有者，然後啟動：

```sh
mkdir -p cache data download log tmp
sudo chown -R "$(id -u):$(id -g)" cache data download log tmp
docker compose up -d
```

範例 Compose 會將容器的 `12345` port 映射到主機，並把 cache、data、download、log、tmp 保存在 `example` 目錄。請依 H@H 客戶端設定調整 `compose.yaml` 的 port 映射。

查看狀態及日誌：

```sh
docker compose ps
docker compose logs -f hath
```

停止服務：

```sh
docker compose down
```

## 使用 Docker CLI

```sh
docker run -d \
  --name hath \
  --restart unless-stopped \
  -p 12345:12345 \
  --user "$(id -u):$(id -g)" \
  -v ./cache:/hath/cache \
  -v ./data:/hath/data \
  -v ./download:/hath/download \
  -v ./log:/hath/log \
  -v ./tmp:/hath/tmp \
  -e HATH_CLIENT_ID='你的 H@H client id' \
  -e HATH_CLIENT_KEY='你的 H@H client key' \
  -e UMASK=077 \
  -e TZ=Asia/Taipei \
  cloverdefa/hath:latest
```

執行前請先建立掛載目錄，並確保其擁有者與 `--user` 指定的 UID/GID 相同。若需使用 image 內建的 `hath` 帳號（UID/GID 1000），可省略 `--user`，並將目錄擁有者設為 `1000:1000`。

## 設定

| 環境變數 | 必要 | 說明 |
| --- | --- | --- |
| `HATH_CLIENT_ID` | 是 | H@H client ID。首次啟動時與 KEY 一起寫入 `/hath/data/client_login`。 |
| `HATH_CLIENT_KEY` | 是 | H@H client key。首次啟動後，修改環境變數不會覆寫既有的 `client_login`。 |
| `UMASK` | 否 | 建立檔案時使用的 umask；預設不額外設定。接受 1 至 4 位八進位數字，例如 `077`。 |
| `TZ` | 否 | 時區；範例使用 `Asia/Taipei`。 |
| `PROXY_HOST` | 否 | 傳給 H@H 的 image proxy 主機。 |
| `PROXY_TYPE` | 否 | 傳給 H@H 的 image proxy 類型。 |
| `PROXY_PORT` | 否 | 傳給 H@H 的 image proxy port。 |
| `JAVA_OPTS` | 否 | 傳給 Java 的額外啟動選項，例如 `-Xms256m -Xmx1g`。 |

`PROXY_*` 只有在有設定時才會傳入客戶端。若要變更 H@H 監聽 port，請依 H@H 客戶端支援的設定調整其設定檔及 Docker port 映射，兩者需一致。

## 身份與目錄權限

映像內建 `hath` 使用者，UID/GID 為 `1000:1000`。Docker Compose 範例指定 `user: "1000:1000"`；若要使用其他 UID/GID，請修改 `user`，並讓所有 bind mount 目錄由相同 UID/GID 擁有。否則容器可能因無法寫入而停止，啟動腳本會指出發生問題的目錄。

容器使用以下持久化目錄：

| 容器路徑 | 用途 |
| --- | --- |
| `/hath/cache` | H@H 快取 |
| `/hath/data` | H@H 資料及 `client_login` 憑證檔 |
| `/hath/download` | 下載資料 |
| `/hath/log` | 日誌 |
| `/hath/tmp` | 暫存檔 |

請保留 `/hath/data`，否則重建容器後需要重新初始化登入資料。`client_login` 會以權限 `600` 建立。

## Health check

Docker health check 每 90 秒檢查 H@H Java 程序及容器內是否有 TCP port 在監聽；啟動寬限時間為 60 秒，連續 3 次失敗後標記為 unhealthy。

## 映像與原始碼

- Docker Hub：<https://hub.docker.com/r/cloverdefa/hath>
- 原始碼：<https://github.com/cloverdefa/hath-docker>

## 貢獻

歡迎提交 Issue 或 Pull Request。請先 fork 專案、建立分支、提交變更，再向 GitHub 發送 Pull Request。

## 授權

本專案採用 MIT License，詳見 [LICENSE.md](LICENSE.md)。
