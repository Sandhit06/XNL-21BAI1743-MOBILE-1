const express = require('express');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.cert(require('./config/firebase-service.json')),
});

const app = express();
app.use(express.json());

app.post('/send', async (req, res) => {
    const { token, message } = req.body;
    await admin.messaging().send({ token, notification: { title: 'Alert', body: message } });
    res.send('Notification sent');
});

app.listen(4003, () => console.log('Notification Service running on port 4003'));
