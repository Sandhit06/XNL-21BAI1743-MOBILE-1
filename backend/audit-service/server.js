const express = require('express');
const mongoose = require('mongoose');
const AuditLog = require('./models/AuditLog');

const app = express();
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/auditDB', { useNewUrlParser: true, useUnifiedTopology: true });

app.post('/log', async (req, res) => {
    const log = new AuditLog(req.body);
    await log.save();
    res.json(log);
});

app.listen(4004, () => console.log('Audit Service running on port 4004'));
