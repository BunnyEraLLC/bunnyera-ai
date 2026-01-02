# MCP 授權規範 · 第 4 部分  
# 授權流程（Authorization Flow）

## 1. MCP 使用哪種授權流程？

MCP **強制使用 OAuth 2.1 授權碼流程（Authorization Code Flow）**  
並且 **強制啟用 PKCE（S256）**。

這意味著：

- 不允許隱式流程（Implicit Flow）  
- 不允許密碼流程（Password Flow）  
- 不允許 Client Secret 出現在桌面或瀏覽器  
- 所有授權都必須透過授權碼 + PKCE  

這是目前最安全、最現代化的 OAuth 授權方式。

---

## 2. 授權流程總覽（簡化版）

### ① 用戶端 → MCP 伺服器  
請求受保護資源（無 Token）

### ② MCP 伺服器 → 用戶端  
回傳 401 + resource_metadata

### ③ 用戶端 → 授權伺服器  
發起授權請求（含 PKCE）

### ④ 使用者 → 授權伺服器  
登入並同意授權

### ⑤ 授權伺服器 → 用戶端  
回傳授權碼（code）

### ⑥ 用戶端 → 授權伺服器  
以 code + code_verifier 換取 Token

### ⑦ 用戶端 → MCP 伺服器  
攜帶 Token 存取受保護資源

---

## 3. 授權請求（Authorization Request）

用戶端會開啟瀏覽器，導向：
GET https://auth.example.com/authorize? response_type=code &client_id=abc123 &redirect_uri=http://localhost:12345/callback &scope=read write &code_challenge=xxxx &code_challenge_method=S256 &resource=https://api.example.com

### 重要參數說明：

| 參數 | 說明 |
|------|------|
| response_type=code | 授權碼流程 |
| client_id | 用戶端身份 |
| redirect_uri | 授權碼回傳位置 |
| scope | 要求的權限 |
| code_challenge | PKCE 挑戰碼 |
| code_challenge_method=S256 | 強制使用 S256 |
| resource | Token 的 audience |

---

## 4. 使用者授權頁面

授權伺服器會顯示：

- 用戶端名稱  
- 用戶端圖示  
- 請求的 scope  
- 請求的資源（resource）  
- 隱私政策（如有）  

使用者可以：

- 同意  
- 拒絕  

---

## 5. 授權碼回傳（Authorization Code）

授權伺服器會將使用者導回：
http://localhost:12345/callback?code=XYZ

用戶端接收 code 後，進入下一步。

---

## 6. Token 交換（Token Exchange）

用戶端 POST：
POST https://auth.example.com/token Content-Type: application/x-www-form-urlencoded
grant_type=authorization_code code=XYZ redirect_uri=http://localhost:12345/callback code_verifier=YYYY resource=https://api.example.com

授權伺服器回傳：

```json
{
  "access_token": "eyJhbGciOi...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "scope": "read write",
  "refresh_token": "def456"
}



7. 使用 Token 存取 MCP 伺服器
用戶端在 HTTP Header 加上：
Authorization: Bearer <access_token>


MCP 伺服器會驗證：
- Token 是否有效
- Token 是否屬於該伺服器（audience）
- Token 是否包含所需 scope
- Token 是否過期

8. Token 過期時的行為
如果 Token 過期：
- 用戶端可使用 refresh_token 換取新的 access_token
- 若 refresh_token 也過期 → 重新授權

9. scope 不足時的行為
如果 Token scope 不足：
伺服器回傳：
403 insufficient_scope


用戶端會自動：
- 發起升級授權流程
- 要求更多 scope
- 重新取得 Token

10. 授權流程安全要求
MCP 強制：
- 必須使用 PKCE
- 必須使用 HTTPS
- 必須使用完整匹配的 redirect_uri
- 不允許 Implicit Flow
- 不允許 Client Secret 出現在桌面或瀏覽器
- Token 必須綁定 audience（resource）

第 4 部分結束

---

如果你要下一部分，直接說：

**下一个**


授權伺服器回傳：

```json
{
  "access_token": "eyJhbGciOi...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "scope": "read write",
  "refresh_token": "def456"
}
7. 使用 Token 存取 MCP 伺服器
用戶端在 HTTP Header 加上：
Authorization: Bearer <access_token>
MCP 伺服器會驗證：
- Token 是否有效
- Token 是否屬於該伺服器（audience）
- Token 是否包含所需 scope
- Token 是否過期

8. Token 過期時的行為
如果 Token 過期：
- 用戶端可使用 refresh_token 換取新的 access_token
- 若 refresh_token 也過期 → 重新授權

9. scope 不足時的行為
如果 Token scope 不足：
伺服器回傳：
403 insufficient_scope


用戶端會自動：
- 發起升級授權流程
- 要求更多 scope
- 重新取得 Token

10. 授權流程安全要求
MCP 強制：
- 必須使用 PKCE
- 必須使用 HTTPS
- 必須使用完整匹配的 redirect_uri
- 不允許 Implicit Flow
- 不允許 Client Secret 出現在桌面或瀏覽器
- Token 必須綁定 audience（resource）


