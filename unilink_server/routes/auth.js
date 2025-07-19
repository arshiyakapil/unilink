const express = require('express');
const router = express.Router();
const User = require('../models/User');
const jwt = require('jsonwebtoken');
const validator = require('validator');
const auth = require('../middleware/auth');

// Signup endpoint
router.post('/signup', async (req, res) => {
  const { uniId, idCardImage } = req.body;
  if (!uniId || !idCardImage) {
    console.warn('Missing uniId or idCardImage');
    return res.status(400).json({ error: "Missing required fields" });
  }
  if (!validator.isAlphanumeric(uniId) || uniId.length !== 8) {
    console.warn('Invalid University ID format');
    return res.status(400).json({ error: "Invalid University ID" });
  }
  try {
    const user = await User.create({
      uniId,
      idCardImage,
      status: 'pending_verification'
    });
    console.info(`User created: ${user.uniId}`);
    res.status(201).json(user);
  } catch (err) {
    console.error('Signup error:', err);
    res.status(500).json({ error: err.message });
  }
});

// Login endpoint
router.post('/login', async (req, res) => {
  const { uniId } = req.body;
  if (!uniId) {
    return res.status(400).json({ error: 'University ID required' });
  }
  if (!validator.isAlphanumeric(uniId) || uniId.length !== 8) {
    return res.status(400).json({ error: 'Invalid University ID format' });
  }
  try {
    const user = await User.findOne({ uniId });
    if (!user) {
      return res.status(404).json({ error: 'ID not found' });
    }
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '1d' });
    res.json({ token });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ error: err.message });
  }
});

// Verification status endpoint
router.get('/status/:uniId', async (req, res) => {
  const { uniId } = req.params;
  if (!validator.isAlphanumeric(uniId) || uniId.length !== 8) {
    return res.status(400).json({ error: 'Invalid University ID format' });
  }
  try {
    const user = await User.findOne({ uniId });
    if (!user) {
      return res.status(404).json({ error: 'ID not found' });
    }
    res.json({ status: user.status });
  } catch (err) {
    console.error('Status check error:', err);
    res.status(500).json({ error: err.message });
  }
});

// Profile editing endpoint
router.patch('/user', auth, async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(req.userId, req.body, { new: true });
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (err) {
    console.error('Profile update error:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
