# Repository Guidelines

## Project Structure & Module Organization
- `docker/`: 主要 Dockerfile 與 `.dockerignore`。
- `start/`: 進入點腳本 `run.sh`（在容器內執行）。
- `example/`: `docker-compose.yml` 與 `.env` 範例/參考。
- `.github/`: CI 工作流程（若有）。
- 根目錄：`README.md`, `LICENSE.md`, `SECURITY.md`。

## Build, Test, and Development Commands
- 建置映像: `docker build -t hath:dev -f docker/Dockerfile .`
- 本機執行（單容器）: 參照 `README.md` 的 `docker run ...` 範例。
- 使用 Compose: `docker compose -f example/docker-compose.yml --env-file example/.env up -d`
- 檢視日誌: `docker logs -f hath`
- 檢查健康度: `docker inspect --format '{{json .State.Health}}' hath`
- 進入容器: `docker exec -it hath sh`

## Coding Style & Naming Conventions
- Shell: 採用 POSIX 相容（`ash`/`sh`），避免 bashisms；縮排 2 空格；嚴格檢查退出碼；變數 `UPPER_SNAKE_CASE` 用於環境變數（如 `HATH_CLIENT_ID`）。
- Dockerfile: 保持層數精簡、固定版本（如 `ARG HATH_VERSION` 與基底映像 tag）；必要檔案再複製；指令排序由安裝→設定→清理。
- 建議工具（選用）：`shellcheck` 檢查 `run.sh`、`hadolint` 檢查 Dockerfile。

## Testing Guidelines
- 無單元測試；以端對端驗證為主：成功建置、容器啟動、`HEALTHCHECK` 為 healthy、日誌無錯誤。
- 覆蓋場景：有/無 Proxy 參數、不同 `UMASK`、掛載卷是否正確建立（`/hath/{cache,data,download,log,tmp}`）。
- 若修改啟動參數或目錄，請同步更新 `example/docker-compose.yml` 與 `README.md` 範例。

## Commit & Pull Request Guidelines
- Commit: 建議使用 Conventional Commits（例如 `feat:`, `fix:`, `docs:`）；主旨使用祈使語氣且簡潔，必要時附詳述。
- PR 內容：
  - 說明動機與變更摘要，連結相關 Issue。
  - 附上本地驗證步驟與關鍵輸出（建置指令、`docker ps` 狀態、日誌節錄）。
  - 若影響使用方式，請更新文件與範例；勿提交含機密的 `.env`。

## Security & Configuration Tips
- 切勿提交私密金鑰或 `.env`；本地可設 `chmod 600 .env`。
- 依需求設定 `TZ`、`UMASK`；必要時在 Compose 暴露對應埠並設網路策略。
