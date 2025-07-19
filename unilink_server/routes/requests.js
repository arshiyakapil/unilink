const express = require('express');
const router = express.Router();
const Request = require('../models/Request');
const auth = require('../middleware/auth');

// Create request (protected)
router.post('/', auth, async (req, res) => {
  const request = await Request.create({
    ...req.body,
    creator: req.userId
  });
  res.status(201).json(request);
});

// Get all requests
router.get('/', async (req, res) => {
  const requests = await Request.find().populate('creator', 'uniId');
  res.json(requests);
});

module.exports = router;
