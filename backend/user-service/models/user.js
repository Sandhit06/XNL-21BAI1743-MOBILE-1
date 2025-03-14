const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    uid: String,
    name: String,
    email: String,
    phone: String,
    balance: Number,
});

module.exports = mongoose.model('User', UserSchema);
