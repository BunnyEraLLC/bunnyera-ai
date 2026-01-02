# MCP 授權規範 · 第 2 部分  
# 授權伺服器發現（Authorization Server Discovery）

## 1. 為什麼需要「發現」？

MCP 用戶端第一次連線 MCP 伺服器時：

- 它不知道授權伺服器在哪裡  
- 不知道 Token 要去哪裡換  
- 不知道支援哪些 scope  
- 不知道是否支援 PKCE  
- 不知道是否需要動態註冊  

因此 MCP 採用 **OAuth 2.0 授權伺服器中繼資料（RFC 8414）**  
讓用戶端能自動找到授權伺服器。

---

## 2. MCP 伺服器如何告訴用戶端「去哪裡發現」？

當用戶端沒有 Token 或 Token 無效時，MCP 伺服器會回應：

401 Unauthorized WWW-Authenticate: Bearer resource_metadata="https://example.com/.well-known/oauth-protected-resource"


其中：

- `resource_metadata` 指向 **受保護資源中繼資料文件（RFC 9728）**
- 用戶端從這裡找到授權伺服器資訊

---

## 3. 受保護資源中繼資料（Protected Resource Metadata）

URL 通常為：

https://<server>/.well-known/oauth-protected-resource


內容範例：

```json
{
  "authorization_servers": [
    "https://auth.example.com"
  ],
  "resource": "https://api.example.com",
  "scopes_supported": ["read", "write", "admin"]
}

用戶端會從這裡取得：
- 授權伺服器列表
- 資源識別子（audience）
- 支援的 scope

4. 授權伺服器中繼資料（Authorization Server Metadata）
用戶端接著會請求：
https://auth.example.com/.well-known/openid-configuration
或：
https://auth.example.com/.well-known/oauth-authorization-server
授權伺服器會回傳：
{
  "issuer": "https://auth.example.com",
  "authorization_endpoint": "https://auth.example.com/authorize",
  "token_endpoint": "https://auth.example.com/token",
  "jwks_uri": "https://auth.example.com/jwks.json",
  "scopes_supported": ["read", "write", "admin"],
  "grant_types_supported": ["authorization_code"],
  "code_challenge_methods_supported": ["S256"]
}
用戶端從這裡取得：
- 授權端點
- Token 端點
- 支援的 PKCE 方法
- 支援的 scope
- JWT 金鑰位置（jwks_uri）

5. 發現流程總結（簡化版）
① 用戶端 → MCP 伺服器
請求受保護資源（無 Token）
② MCP 伺服器 → 用戶端
回傳 401 + resource_metadata
③ 用戶端 → resource_metadata URL
取得受保護資源中繼資料
④ 用戶端 → 授權伺服器 metadata URL
取得授權伺服器中繼資料
⑤ 用戶端準備授權流程
（知道授權端點、Token 端點、scope、PKCE 支援等）

6. 為什麼 MCP 必須使用「雙層發現」？
MCP 使用：
- 受保護資源中繼資料（RFC 9728）
- 授權伺服器中繼資料（RFC 8414）
原因：
- MCP 伺服器與授權伺服器可能不是同一個域名
- MCP 伺服器可能對接多個授權伺服器
- 不同資源可能有不同 scope
- 允許企業自訂授權架構
- 允許多租戶（multi-tenant）架構
這讓 MCP 授權系統比一般 OAuth 更靈活。

