# MCP 授權規範 · 第 5 部分  
# 執行階段行為（Runtime Behavior）

本部分描述：  
當 MCP 用戶端已經取得 Token，並開始與 MCP 伺服器互動時，雙方必須遵守的規範與行為。

---

## 1. 用戶端如何在執行階段使用 Token？

用戶端在每次呼叫 MCP 伺服器 API 時，都必須在 HTTP Header 加上：
Authorization: Bearer <access_token>

MCP 伺服器會：

- 驗證 Token 是否有效  
- 驗證 Token 是否屬於該伺服器（audience）  
- 驗證 Token 是否包含所需 scope  
- 驗證 Token 是否過期  

---

## 2. Token 驗證（Token Validation）

MCP 伺服器必須驗證：

### ① Token 是否有效  
- 是否為合法 JWT  
- 是否由授權伺服器簽發  
- 是否使用正確的簽章金鑰（JWKS）  

### ② Token 是否屬於該資源（audience）  
Token 中的 `aud` 必須包含：


https://api.example.com

否則伺服器必須回應：


401 invalid_token

### ③ Token 是否包含所需 scope  
例如：

- API 需要 `read`  
- Token 只有 `basic`  

伺服器必須回應：


403 insufficient_scope

### ④ Token 是否過期  
若 Token 過期，伺服器必須回應：


401 invalid_token

---

## 3. Token 過期後的行為

用戶端可以：

### ① 使用 refresh_token 換取新的 access_token  
（如果授權伺服器支援 refresh_token）

### ② 若 refresh_token 也過期  
→ 用戶端必須重新啟動授權流程

---

## 4. scope 不足時的行為

伺服器回應：


403 insufficient_scope

用戶端必須：

- 自動發起升級授權流程  
- 要求更多 scope  
- 重新取得 Token  

這讓 MCP 用戶端可以在需要時動態提升權限。

---

## 5. 伺服器如何要求升級授權？

伺服器可以在回應中加入：


WWW-Authenticate: Bearer scope="write admin"
用戶端會：

- 解析需要的 scope  
- 自動啟動授權流程  
- 要求使用者同意更多權限  

---

## 6. Token 綁定（Token Binding）

MCP 要求 Token 必須綁定：

- audience（resource）  
- client_id  
- scope  

這可以防止：

- Token 被盜後用於其他伺服器  
- Token 被其他用戶端濫用  
- Token 被跨系統重放  

---

## 7. 多資源（Multi-Resource）支援

MCP 支援：

- 一個授權伺服器  
- 多個 MCP 伺服器（多資源）  

用戶端可以：

- 為不同資源請求不同 Token  
- 或使用同一 Token（若 audience 支援多值）  

---

## 8. 執行階段錯誤碼（Runtime Error Codes）

| 錯誤碼 | 說明 |
|--------|------|
| 401 invalid_token | Token 無效、過期、audience 不符 |
| 403 insufficient_scope | Token scope 不足 |
| 400 invalid_request | 請求格式錯誤 |
| 500 server_error | 伺服器內部錯誤 |

---

## 9. 用戶端執行階段行為總結

### ① 每次請求都必須帶 Token  
### ② Token 驗證失敗 → 401  
### ③ scope 不足 → 403  
### ④ Token 過期 → refresh 或重新授權  
### ⑤ 伺服器可要求升級授權  
### ⑥ Token 必須綁定 audience + client_id  
### ⑦ 支援多資源架構  

---


