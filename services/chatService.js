const openRouter = require('./openRouter');

/**
 * Chat Service
 * Handles business logic for chat interactions.
 */
class ChatService {
    /**
     * Process a chat message
     * @param {string} message - User's message
     * @param {string} model - Model ID to use
     * @param {Array} history - Previous conversation history
     * @returns {Promise<Object>} - AI response
     */
    async processChat(message, model, history = []) {
        try {
            // 1. Construct standard message format
            const messages = [
                ...history,
                { role: 'user', content: message }
            ];

            // 2. Call OpenRouter
            const response = await openRouter.chatCompletion(model, messages);

            // 3. Return formatted result
            return {
                role: response.role,
                content: response.content,
                model: model,
                timestamp: new Date().toISOString()
            };
        } catch (error) {
            console.error('❌ [ChatService] Error processing chat:', error);
            throw error;
        }
    }

    /**
     * Get available models
     * @returns {Promise<Array>} - List of models
     */
    async getAvailableModels() {
        try {
            const models = await openRouter.getModels();
            // Transform or filter models if necessary
            return models.map(m => ({
                id: m.id,
                name: m.name,
                description: m.description,
                context_length: m.context_length,
                pricing: m.pricing
            }));
        } catch (error) {
            console.error('❌ [ChatService] Error fetching models:', error);
            throw error;
        }
    }
}

module.exports = new ChatService();
