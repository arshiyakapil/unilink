const express = require('express');
const multer = require('multer');
const mongoose = require('mongoose');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
const upload = multer({ dest: 'uploads/' });

mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true });

const IdSchema = new mongoose.Schema({
  name: String,
  regNo: String,
  department: String,
  validity: String,
  bloodGroup: String,
  dob: String,
  address: String,
  pin: String,
  contact: String,
  email: String,
  college: String,
});
const IDModel = mongoose.model('StudentID', IdSchema);

app.post('/api/srm-id', upload.fields([{ name: 'front' }, { name: 'back' }]), async (req, res) => {
  try {
    const { college } = req.body;
    const frontPath = req.files.front[0].path;
    const backPath = req.files.back[0].path;

    const extract = async (path) => {
      const form = new FormData();
      form.append('file', require('fs').createReadStream(path));

      const response = await axios.post('https://api.optiic.dev/api/extract', form, {
        headers: {
          Authorization: `Bearer ${process.env.OPTIIC_API_KEY}`,
          ...form.getHeaders(),
        },
      });

      return response.data;
    };

    const frontText = await extract(frontPath);
    const backText = await extract(backPath);

    const allText = frontText.text + '\n' + backText.text;

    const newEntry = new IDModel({
      college,
      name: extractField(allText, /Name[:\-]?\s*(.+)/i),
      regNo: extractField(allText, /Registration\s?No[:\-]?\s*(\w+)/i),
      department: extractField(allText, /Department[:\-]?\s*(.+)/i),
      validity: extractField(allText, /Valid\s*Till[:\-]?\s*(\d{4})/i),
      bloodGroup: extractField(allText, /Blood\s*Group[:\-]?\s*(\w+)/i),
      dob: extractField(allText, /DOB[:\-]?\s*(\d{2}\/\d{2}\/\d{4})/i),
      address: extractField(allText, /Address[:\-]?\s*(.+)/i),
      pin: extractField(allText, /Pin[:\-]?\s*(\d{6})/i),
      contact: extractField(allText, /Contact[:\-]?\s*(\d{10})/i),
      email: extractField(allText, /Email[:\-]?\s*(\S+@\S+)/i),
    });

    await newEntry.save();
    res.status(200).send({ success: true, message: 'Details saved' });
  } catch (err) {
    console.error(err);
    res.status(500).send('Something went wrong');
  }
});

function extractField(text, regex) {
  const match = text.match(regex);
  return match ? match[1].trim() : '';
}

app.listen(5000, () => console.log('Server running on http://localhost:5000'));
