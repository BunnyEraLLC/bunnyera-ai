# MCP 授權規範 · 第 1 部分  
# 授權系統總覽（Overview）

## 1. 授權的目的（Purpose）

MCP 授權系統的目標是：

讓 MCP 用戶端（如控制台、瀏覽器外掛、機器人等）能夠代表使用者安全地存取受保護的 MCP 伺服器資源。

它解決的問題包括：

- 如何識別用戶端  
- 如何讓使用者授權  
- 如何簽發存取權杖（Access Token）  
- 如何驗證權杖  
- 如何限制權限（Scope）  
- 如何防止權杖被盜用或濫用  
- 如何自動發現授權伺服器  

---

## 2. 授權適用範圍（Scope）

本規範適用於：

- 基於 HTTP 的 MCP 傳輸  
- OAuth 2.1 授權流程  
- OAuth 2.0 授權伺服器中繼資料發現  
- OAuth 2.0 動態用戶端註冊  
- OAuth 2.0 受保護資源中繼資料  
- MCP 擴展授權機制  

不適用於：

- STDIO 傳輸（從環境變數取得憑證）  
- 非 HTTP 傳輸（需遵循各自安全規範）

---

## 3. 標準相容性（Standards Compliance）

MCP 授權基於以下標準：

- OAuth 2.1（草案）  
- OAuth 2.0 授權伺服器中繼資料（RFC 8414）  
- OAuth 2.0 動態用戶端註冊（RFC 7591）  
- OAuth 2.0 受保護資源中繼資料（RFC 9728）  
- OAuth Client ID Metadata Document（草案）

MCP 並非完全實作 OAuth，而是：

只實作必要部分，以確保安全性與互通性，同時保持簡潔。

---

## 4. 角色（Roles）

| 角色 | 描述 |
|------|------|
| MCP 伺服器（資源伺服器） | 提供受保護資源，驗證 Token |
| MCP 用戶端 | 代表使用者存取資源 |
| 授權伺服器（AS） | 處理使用者授權、簽發 Token |

授權伺服器可以：

- 與 MCP 伺服器屬於同一實體  
- 或獨立部署  

---

## 5. 授權系統整體流程（可讀版）

以下是 MCP 授權的完整流程（簡化版）：

### ① 用戶端存取 MCP 伺服器（無 Token）

伺服器回應：

401 Unauthorized  
WWW-Authenticate: Bearer resource_metadata="..."

---

### ② 用戶端依據 resource_metadata 找到授權伺服器

用戶端會自動發現：

- 授權伺服器位置  
- 授權端點  
- Token 端點  
- 支援的 scope  
- 是否支援 PKCE  

---

### ③ 用戶端註冊身份（Client ID）

可能方式：

- Client ID Metadata Document（推薦）  
- 動態用戶端註冊  
- 預先註冊  

---

### ④ 用戶端發起授權請求（含 PKCE）

授權伺服器會顯示：

- 用戶端名稱  
- 請求的 scope  
- 請求的資源  

使用者點擊「允許」。

---

### ⑤ 用戶端以授權碼交換 Token

用戶端傳送：

- code  
- code_verifier  
- resource 參數  

授權伺服器回傳：

- access_token  
- refresh_token（可選）  

---

### ⑥ 用戶端攜帶 Token 存取 MCP 伺服器

請求標頭：

Authorization: Bearer <token>

伺服器驗證：

- Token 是否有效  
- Token 是否屬於該伺服器（audience）  
- Token 是否包含所需 scope  

---

### ⑦ Token 過期或 scope 不足 → 觸發升級授權流程

伺服器回應：

403 insufficient_scope

用戶端自動發起升級授權流程。

---

# 第 1 部分結束
