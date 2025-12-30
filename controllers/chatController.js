const chatService = require('../services/chatService');

/**
 * Chat Controller
 * Handles HTTP requests for chat functionality.
 */
class ChatController {
    /**
     * Handle chat message request
     * POST /api/chat
     */
    async sendMessage(req, res) {
        try {
            const { message, model, history } = req.body;

            // 1. Validation
            if (!message) {
                return res.status(400).json({
                    code: 400,
                    message: "Message is required",
                    error: "VALIDATION_ERROR",
                    timestamp: new Date().toISOString()
                });
            }

            // 2. Call Service
            // Default model if not provided
            const modelId = model || 'openai/gpt-3.5-turbo';
            
            const result = await chatService.processChat(message, modelId, history);

            // 3. Success Response
            return res.status(200).json({
                code: 200,
                message: "Success",
                data: result,
                timestamp: new Date().toISOString()
            });

        } catch (error) {
            console.error('❌ [ChatController] Error:', error);
            return res.status(500).json({
                code: 500,
                message: "Internal Server Error",
                error: error.message,
                timestamp: new Date().toISOString()
            });
        }
    }

    /**
     * Get available models
     * GET /api/chat/models
     */
    async listModels(req, res) {
        try {
            const models = await chatService.getAvailableModels();

            return res.status(200).json({
                code: 200,
                message: "Success",
                data: models,
                meta: {
                    total: models.length
                },
                timestamp: new Date().toISOString()
            });
        } catch (error) {
            console.error('❌ [ChatController] Error fetching models:', error);
            return res.status(500).json({
                code: 500,
                message: "Failed to fetch models",
                error: error.message,
                timestamp: new Date().toISOString()
            });
        }
    }
}

module.exports = new ChatController();
