const mongoose = require('mongoose');
const requestSchema = new mongoose.Schema({
  type: { type: String, enum: ['carpool', 'food', 'project', 'study'] },
  title: String,
  description: String,
  creator: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  location: String,
  createdAt: { type: Date, default: Date.now }
});
module.exports = mongoose.model('Request', requestSchema);
