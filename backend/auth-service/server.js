const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.cert(require('./config/firebase-service.json')),
});

const app = express();
app.use(bodyParser.json());

app.post('/login', async (req, res) => {
    const { token } = req.body;
    try {
        const decodedToken = await admin.auth().verifyIdToken(token);
        res.json({ uid: decodedToken.uid, email: decodedToken.email });
    } catch (error) {
        res.status(401).send('Invalid Token');
    }
});

app.listen(4000, () => console.log('Auth Service running on port 4000'));
