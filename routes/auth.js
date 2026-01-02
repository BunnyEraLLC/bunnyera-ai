const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs'); // 如果报错找不到模块，请看第二步
const jwt = require('jsonwebtoken');
const { User } = require('../models'); // 确保这里指向你的 models 文件夹

const JWT_SECRET = process.env.JWT_SECRET || 'bunnyera_secret_key_default';

// 1. 注册接口
router.post('/register', async (req, res) => {
  try {
    const { username, password } = req.body;
    
    // 检查必填项
    if (!username || !password) {
      return res.status(400).json({ error: '缺少用户名或密码' });
    }

    // 检查用户是否已存在
    const existingUser = await User.findOne({ where: { username } });
    if (existingUser) {
      return res.status(400).json({ error: '用户已存在' });
    }

    // 密码加密
    const hashedPassword = await bcrypt.hash(password, 10);

    // 创建用户
    const newUser = await User.create({
      username,
      password: hashedPassword
    });

    res.status(201).json({ 
      message: '注册成功', 
      user: { id: newUser.id, username: newUser.username } 
    });

  } catch (error) {
    console.error('注册错误:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 2. 登录接口
router.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    // 查找用户
    const user = await User.findOne({ where: { username } });
    if (!user) {
      return res.status(401).json({ error: '用户名或密码错误' });
    }

    // 验证密码
    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) {
      return res.status(401).json({ error: '用户名或密码错误' });
    }

    // 生成 Token
    const token = jwt.sign(
      { id: user.id, username: user.username },
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({ 
      message: '登录成功', 
      token: token,
      username: user.username
    });

  } catch (error) {
    console.error('登录错误:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 3. 必须导出 Router
module.exports = router;
