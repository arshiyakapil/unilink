const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  uniId: { type: String, required: true, unique: true },
  idCardImage: { type: String, required: true },
  status: { type: String, default: 'pending_verification' }
});

module.exports = mongoose.model('User', userSchema);
