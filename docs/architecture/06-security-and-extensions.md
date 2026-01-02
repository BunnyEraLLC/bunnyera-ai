
# MCP 授權規範 · 第 6 部分  
# 安全性與擴展（Security & Extensions）

本部分描述 MCP 授權系統的安全要求、威脅模型，以及 MCP 在 OAuth 基礎上新增的擴展能力。

---

# 1. 安全性總覽（Security Overview）

MCP 採用 OAuth 2.1 的安全模型，並強制以下安全要求：

- **強制使用 HTTPS**
- **強制使用授權碼流程（Authorization Code Flow）**
- **強制使用 PKCE（S256）**
- **禁止使用 Implicit Flow**
- **禁止在桌面/瀏覽器用戶端使用 client_secret**
- **Token 必須綁定 audience（resource）**
- **redirect_uri 必須完全匹配**
- **Token 必須可驗證（JWT + JWKS）**

這些要求確保：

- Token 不會被竊取  
- 授權碼不會被攔截  
- Token 不會被跨系統濫用  
- 用戶端無法偽造身份  

---

# 2. 威脅模型（Threat Model）

MCP 授權系統主要防禦以下攻擊：

## ① 授權碼攔截攻擊  
→ PKCE 防禦

## ② Token 竊取攻擊  
→ HTTPS + audience 綁定防禦

## ③ Token 重放攻擊  
→ audience + client_id 綁定防禦

## ④ 惡意用戶端偽造合法用戶端  
→ client_id metadata / 動態註冊防禦

## ⑤ redirect_uri 注入攻擊  
→ 完整匹配 redirect_uri 防禦

## ⑥ 中間人攻擊（MITM）  
→ HTTPS + JWT 簽章防禦

## ⑦ scope 提權攻擊  
→ insufficient_scope + 升級授權流程防禦

---

# 3. Token 安全要求（Token Security Requirements）

MCP 要求 Token 必須：

- 為 JWT 格式  
- 使用授權伺服器的私鑰簽章  
- 可透過 JWKS 公鑰驗證  
- 包含以下欄位：

| 欄位 | 說明 |
|------|------|
| iss | 授權伺服器 |
| aud | 資源伺服器（必須
好的，直接給你 第 6 部分（繁體完整內容），你可以貼進：
06-security-and-extensions.md


這是最後一部分，內容同樣是完整、可直接使用的工程級文檔。

📄 06-security-and-extensions.md（繁體完整內容）
# MCP 授權規範 · 第 6 部分  
# 安全性與擴展（Security & Extensions）

本部分描述 MCP 授權系統的安全要求、威脅模型，以及 MCP 在 OAuth 基礎上新增的擴展能力。

---

# 1. 安全性總覽（Security Overview）

MCP 採用 OAuth 2.1 的安全模型，並強制以下安全要求：

- **強制使用 HTTPS**
- **強制使用授權碼流程（Authorization Code Flow）**
- **強制使用 PKCE（S256）**
- **禁止使用 Implicit Flow**
- **禁止在桌面/瀏覽器用戶端使用 client_secret**
- **Token 必須綁定 audience（resource）**
- **redirect_uri 必須完全匹配**
- **Token 必須可驗證（JWT + JWKS）**

這些要求確保：

- Token 不會被竊取  
- 授權碼不會被攔截  
- Token 不會被跨系統濫用  
- 用戶端無法偽造身份  

---

# 2. 威脅模型（Threat Model）

MCP 授權系統主要防禦以下攻擊：

## ① 授權碼攔截攻擊  
→ PKCE 防禦

## ② Token 竊取攻擊  
→ HTTPS + audience 綁定防禦

## ③ Token 重放攻擊  
→ audience + client_id 綁定防禦

## ④ 惡意用戶端偽造合法用戶端  
→ client_id metadata / 動態註冊防禦

## ⑤ redirect_uri 注入攻擊  
→ 完整匹配 redirect_uri 防禦

## ⑥ 中間人攻擊（MITM）  
→ HTTPS + JWT 簽章防禦

## ⑦ scope 提權攻擊  
→ insufficient_scope + 升級授權流程防禦

---

# 3. Token 安全要求（Token Security Requirements）

MCP 要求 Token 必須：

- 為 JWT 格式  
- 使用授權伺服器的私鑰簽章  
- 可透過 JWKS 公鑰驗證  
- 包含以下欄位：

| 欄位 | 說明 |
|------|------|
| iss | 授權伺服器 |
| aud | 資源伺服器（必須匹配） |
| sub | 使用者 ID |
| client_id | 用戶端 ID |
| scope | 權限列表 |
| exp | 過期時間 |

---

# 4. audience（resource）綁定

MCP 強制要求：


Token 必須只能用於特定 MCP 伺服器

例如：


aud = "https://api.bunnyera.com"

如果 Token 被送到：


https://api.other.com

伺服器必須拒絕：


401 invalid_token

這能防止：

- Token 被盜後跨系統使用  
- Token 在不同服務之間重放  

---

# 5. scope 擴展（Scope Extensions）

MCP 支援自訂 scope，例如：

- read  
- write  
- admin  
- mcp.tools.run  
- mcp.files.read  
- mcp.files.write  

伺服器可以定義：

- 哪些 API 需要哪些 scope  
- 哪些 scope 可以升級授權  
- 哪些 scope 只能由管理員授權  

---

# 6. 升級授權（Incremental Authorization）

MCP 支援：


用戶端在需要更多權限時，自動要求使用者授權更多 scope

伺服器回應：


403 insufficient_scope WWW-Authenticate: Bearer scope="write admin"

用戶端會：

- 自動啟動授權流程  
- 要求使用者同意更多權限  
- 取得新的 Token  

這讓 MCP 用戶端可以：

- 先以最低權限運作  
- 需要時再提升權限  
- 避免一次要求過多 scope  

---

# 7. 多資源授權（Multi-Resource Authorization）

MCP 支援：

- 一個授權伺服器  
- 多個 MCP 伺服器（多資源）  

用戶端可以：

- 為不同資源請求不同 Token  
- 或使用同一 Token（若 audience 支援多值）  

這對大型企業架構非常重要。

---

# 8. 擴展能力（Extensions）

MCP 在 OAuth 基礎上新增：

## ① resource_metadata（RFC 9728）  
讓 MCP 伺服器能告訴用戶端：

- 授權伺服器位置  
- 支援的 scope  
- audience  

## ② Client ID Metadata Document  
讓用戶端能自動提供：

- 名稱  
- 圖示  
- redirect_uri  
- 隱私政策  

## ③ 升級授權流程  
讓用戶端能在需要時提升 scope。

---

# 9. 安全性總結

### MCP 強制：

- OAuth 2.1  
- 授權碼流程  
- PKCE  
- audience 綁定  
- redirect_uri 完整匹配  
- JWT + JWKS 驗證  
- HTTPS  

### MCP 擴展：

- resource_metadata  
- client metadata  
- incremental authorization  
- multi-resource 支援  

---

