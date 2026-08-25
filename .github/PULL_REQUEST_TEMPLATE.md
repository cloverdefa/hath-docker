## Summary

<!--
請簡述這個 PR 的目的與背景。

請說明：
- 為什麼需要這個修改？
- 解決了什麼問題？
- 希望達成什麼結果？

請避免只寫「更新 Docker」、「修正設定」等過於籠統的描述。
-->

## Changes

<!--
請列出這個 PR 實際修改的內容。

建議使用條列式，並盡量具體說明：
- 修改了哪些 Dockerfile、Shell Script、Docker Compose 或設定檔？
- 新增、修改或移除了哪些功能？
- 是否調整 Container、Volume、Network、Port 或 Environment Variables？
- 是否調整 H@H Client 版本？
- 是否影響 Docker Image Build 或 Docker Hub Release？
-->

-

## Docker / Deployment Details

<!--
如果這個 PR 涉及 Docker 或部署行為，請說明相關變更。

### Docker Image

- Image：
- Tag：
- Base Image：
- 是否需要重新 Build：

### Container

- Container User：
- UID / GID：
- Environment Variables：
- Port：
- Network：

### Volumes

<!--
如果涉及 Volume，請說明：
- 新增 / 修改 / 移除哪些 Volume？
- Container Path：
- Host Path：
- 是否需要調整 Host 端目錄權限？
-->

### Docker Compose

<!--
如果修改 docker-compose.yml，請說明：
- 修改哪些 Service？
- 是否新增或修改 Environment Variables？
- 是否修改 Volume / Network / Port？
- 舊有 Compose 設定是否仍然相容？
-->
    
## Testing

<!--
請說明你如何驗證這次修改。

請盡可能提供：
- 測試環境
- Docker 版本
- Docker Compose 版本
- Host OS
- 測試方法
- 測試結果

如果涉及 Docker，建議確認：

- Docker Image 可以正常 Build
- Container 可以正常啟動
- Container 可以正常停止及重新啟動
- Docker Compose 可以正常啟動
- Volume 可以正常掛載
- Container 可以正常讀寫 Volume
- UID / GID 設定符合預期
- 不會發生 Permission denied
- Environment Variables 可以正常傳入
- Port / Network 可以正常運作
- H@H Client 可以正常啟動
- H@H Client 可以正常執行基本功能
- Log 可以正常產生

如果涉及 Docker Hub / Release，請確認：
- Image 可以正常 Push
- Image 可以正常 Pull
- 新 Image 可以正常啟動
- Tag 符合專案版本規範

如果無法進行完整測試，請明確說明原因。
-->

## Breaking Changes

<!--
請確認這個 PR 是否會改變現有使用者的部署方式或容器行為。

如果有 Breaking Change，請明確說明：
- 哪些設定受到影響？
- 使用者需要修改哪些 Docker Compose / .env 設定？
- 是否需要重新建立 Container？
- 是否需要重新建立 Volume？
- 是否需要修改 Volume 目錄權限？
- 是否需要重新 Pull Docker Image？
- 是否需要重新建立或修改 Environment Variables？

如果沒有 Breaking Change，請填寫「無」。
-->

## Related Issues

<!--
如果這個 PR 與 Issue、Discussion 或其他 PR 有關，請在此列出。

例如：

- Relates to #123
- Fixes #123
- Closes #123

如果沒有相關項目，請填寫「無」。
-->

## Additional Notes

<!--
請提供 Reviewer 需要知道的其他資訊。

例如：
- 已知限制
- 尚未解決的問題
- Docker / Docker Compose 相容性問題
- 特定 Linux 發行版的差異
- UID / GID 或 Volume 權限相關注意事項
- H@H Client 版本相依性
- Base Image 版本相依性
- 需要 Reviewer 特別測試的部署情境
- 為什麼採用目前的 Docker 實作方式
-->

<details>
<summary>Checklist</summary>

- [ ] 我已確認這個 PR 的目的與修改內容已清楚說明
- [ ] 我已確認 Dockerfile / Shell Script / Compose 設定符合專案規範
- [ ] 我已自行 Review 此次變更
- [ ] 我已完成適當的本機測試
- [ ] 我已確認 Docker Image 可以正常 Build（如適用）
- [ ] 我已確認 Container 可以正常啟動（如適用）
- [ ] 我已確認 Container 可以正常停止及重新啟動（如適用）
- [ ] 我已確認 Docker Compose 可以正常啟動（如適用）
- [ ] 我已確認 Volume 可以正常掛載及讀寫（如適用）
- [ ] 我已確認 UID / GID 設定符合預期（如適用）
- [ ] 我已確認 Host 端 Volume 目錄權限正確（如適用）
- [ ] 我已確認沒有 Permission denied 等權限問題（如適用）
- [ ] 我已確認 Environment Variables 可以正常使用（如適用）
- [ ] 我已確認 Port / Network 設定正常（如適用）
- [ ] 我已確認 H@H Client 可以正常啟動及運作（如適用）
- [ ] 我已確認 Log 可以正常產生（如適用）
- [ ] 我已確認 Docker Hub Image 可以正常 Pull / 啟動（如適用）
- [ ] 我已確認 GitHub Actions / CI 通過（如適用）
- [ ] 我已確認 Release / Image Publish 流程正常（如適用）
- [ ] 我已確認沒有引入 Breaking Change，或已在上方明確說明
- [ ] 我已確認相關測試已新增或更新（如適用）
- [ ] 我已確認必要的文件已新增或更新（如適用）
- [ ] 我已確認沒有提交不必要的檔案、Debug code 或暫存內容
- [ ] 我已確認 `.env`、Client ID、Client Key 或其他敏感資訊沒有被提交
- [ ] 我已確認沒有提交不必要的 Secret、Token 或 Credential
- [ ] 我已確認變更範圍與 PR 目的相符，沒有混入無關修改
- [ ] 我已確認 Commit Message 符合 Conventional Commits 規範
- [ ] 我已確認 Reviewer 可以根據 PR 說明理解這次變更

</details>
