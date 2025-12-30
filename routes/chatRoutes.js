const express = require('express');
const router = express.Router();
const chatController = require('../controllers/chatController');

// Define routes
// POST /api/chat - Send a message
router.post('/', chatController.sendMessage);

// GET /api/chat/models - Get available models
router.get('/models', chatController.listModels);

module.exports = router;
