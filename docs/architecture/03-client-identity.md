# MCP 授權規範 · 第 3 部分  
# 用戶端身份（Client Identity）

## 1. 為什麼 MCP 需要「用戶端身份」？

MCP 授權流程中，不只使用者需要被識別，用戶端本身也必須被識別。

原因包括：

- 授權伺服器需要知道「是哪個用戶端」在請求授權  
- 使用者授權畫面需要顯示用戶端名稱  
- Token 必須綁定到特定用戶端  
- 防止惡意用戶端偽造合法用戶端  
- 支援多個不同的 MCP 用戶端（桌面、瀏覽器、行動裝置等）  

因此 MCP 採用 **Client ID（用戶端識別碼）** 來標示每個用戶端。

---

## 2. MCP 用戶端身份的三種來源

MCP 支援三種方式取得 Client ID：

### ① **Client ID Metadata Document（推薦）**

用戶端提供一個 URL，內容包含：

- 用戶端名稱  
- 用戶端描述  
- 用戶端圖示  
- 用戶端隱私政策  
- 用戶端支援的 redirect URI  

範例：

```json
{
  "client_name": "BunnyEra Console",
  "client_uri": "https://console.bunnyera.com",
  "logo_uri": "https://console.bunnyera.com/logo.png",
  "redirect_uris": [
    "http://localhost:12345/callback"
  ]
}
授權伺服器會：
- 下載這份文件
- 驗證內容
- 自動建立 Client ID
這是 MCP 官方推薦方式。

② 動態用戶端註冊（Dynamic Client Registration）
用戶端向授權伺服器 POST：

{
  "client_name": "BunnyEra Console",
  "redirect_uris": ["http://localhost:12345/callback"]
}
授權伺服器回傳：
{
  "client_id": "abc123",
  "client_secret": "xyz789"
}
適用於：
- 企業內部系統
- 自動化部署
- 多租戶架構

③ 預先註冊（Pre-registered Clients）
授權伺服器預先設定：
- client_id
- redirect_uri
- scope
- logo
- 名稱
適用於：
- 官方應用
- 企業內部固定用戶端
- 不允許動態註冊的環境
3. MCP 用戶端身份的最小要求
無論使用哪種方式，MCP 用戶端至少需要：
|  |  | 
|  |  | 
|  |  | 
|  |  | 
|  |  | 
|  |  | 



4. 為什麼 MCP 強制要求「redirect_uri」？
因為：
- 授權碼必須回傳到安全的位置
- 防止攻擊者竄改 redirect_uri
- 防止授權碼被攔截
- 防止 Token 被竊取
MCP 採用 OAuth 2.1 的安全規範：
- redirect_uri 必須完全匹配
- 不允許 wildcard（如 *）
- 不允許 query 改變 redirect_uri

5. 用戶端身份與 PKCE 的關係
MCP 採用：
- 授權碼流程（Authorization Code Flow）
- 強制 PKCE（Proof Key for Code Exchange）
這意味著：
- 用戶端不需要 client_secret
- 用戶端可以是 public client（如桌面應用）
- 安全性依靠 PKCE，而不是密鑰
這對：
- BunnyEra Console
- BunnyEra Browser
- BunnyEra AI Desktop
非常重要。

6. 用戶端身份的安全要求
MCP 要求：
- client_id 必須是公開資訊（不保密）
- client_secret 不應用於桌面或瀏覽器用戶端
- redirect_uri 必須固定
- client_id 必須綁定到授權伺服器
- Token 必須綁定到 client_id

7. 用戶端身份流程總結
① 用戶端啟動
→ 準備 client_id 或 metadata URL
② MCP 伺服器要求授權
→ 回傳 resource_metadata
③ 用戶端發現授權伺服器
→ 下載 metadata
④ 用戶端註冊（如需要）
→ 取得 client_id
⑤ 用戶端開始授權流程
→ 使用 client_id + PKCE


