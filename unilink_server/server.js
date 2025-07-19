const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const WebSocket = require('ws');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

// Rate limiting
const limiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 100 });
app.use(limiter);

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('MongoDB Connected'))
  .catch(err => console.error(err));

// Import and use auth routes
const authRoutes = require('./routes/auth');
app.use('/api', authRoutes);

// Import and use requests routes
const requestsRoutes = require('./routes/requests');
app.use('/api/requests', requestsRoutes);

// Test endpoint
app.get('/api/test', (req, res) => {
  res.json({ message: 'Backend connected!' });
});

// Logging middleware
app.use((req, res, next) => {
  console.info(`${req.method} ${req.url}`);
  next();
});

// WebSocket server for real-time chat
const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
  ws.on('message', (message) => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message);
      }
    });
  });
});

app.listen(3000, () => console.log('Server running on port 3000'));