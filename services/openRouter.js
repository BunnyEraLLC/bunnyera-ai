const OpenAI = require('openai');
require('dotenv').config();

// 🐰 BunnyEra OpenRouter Integration
// Documentation: https://openrouter.ai/docs

const openai = new OpenAI({
    baseURL: 'https://openrouter.ai/api/v1',
    apiKey: process.env.OPENROUTER_API_KEY || 'sk-or-your-key-here', // ⚠️ 必须配置
    defaultHeaders: {
        'HTTP-Referer': process.env.APP_URL || 'https://bunnyera.com', // 应用主页
        'X-Title': process.env.APP_NAME || 'BunnyEra AI', // 应用名称
    },
});

/**
 * 发送聊天请求到 OpenRouter
 * @param {string} model - 模型名称 (如 'openai/gpt-4o', 'google/gemini-pro-1.5')
 * @param {Array} messages - 消息历史 [{ role: 'user', content: '...' }]
 * @param {Object} options - 其他参数 (temperature, max_tokens 等)
 * @returns {Promise<Object>} - 返回 message 对象 { role, content }
 */
async function chatCompletion(model, messages, options = {}) {
    try {
        console.log(`🚀 [OpenRouter] Requesting model: ${model}`);
        const completion = await openai.chat.completions.create({
            model: model || 'openai/gpt-3.5-turbo',
            messages: messages,
            ...options
        });

        return completion.choices[0].message;
    } catch (error) {
        console.error('❌ [OpenRouter] Error:', error.message);
        throw error;
    }
}

/**
 * 获取可用模型列表
 */
async function getModels() {
    try {
        const list = await openai.models.list();
        return list.data;
    } catch (error) {
        console.error('❌ [OpenRouter] Failed to fetch models:', error.message);
        return [];
    }
}

module.exports = {
    openai,
    chatCompletion,
    getModels
};
