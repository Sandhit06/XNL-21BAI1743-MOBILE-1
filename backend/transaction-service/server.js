const express = require('express');
const mongoose = require('mongoose');
const Transaction = require('./models/Transaction');

const app = express();
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/transactionDB', { useNewUrlParser: true, useUnifiedTopology: true });

app.post('/transfer', async (req, res) => {
    const { fromUser, toUser, amount } = req.body;
    const transaction = new Transaction({ fromUser, toUser, amount });
    await transaction.save();
    res.json(transaction);
});

app.listen(4002, () => console.log('Transaction Service running on port 4002'));
