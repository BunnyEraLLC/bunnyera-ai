const express = require('express');
const router = express.Router();

let users = [];

// 注册
router.post('/register', (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) {
        return res.status(400).json({ error: 'Missing username or password' });
    }
    const user = { id: Date.now(), username, password };
    users.push(user);
    res.json({ message: 'User registered', user, token: `fake-token-${user.id}` });
});

// 登录
router.post('/login', (req, res) => {
    const { username, password } = req.body;
    const user = users.find(u => u.username === username && u.password === password);
    if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
    }
    res.json({ message: 'Login successful', user, token: `fake-token-${user.id}` });
});

module.exports = router;
