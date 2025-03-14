const express = require('express');
const proxy = require('http-proxy-middleware');

const app = express();
const PORT = process.env.PORT || 3000;

app.use('/auth', proxy.createProxyMiddleware({ target: 'http://localhost:4000', changeOrigin: true }));
app.use('/users', proxy.createProxyMiddleware({ target: 'http://localhost:4001', changeOrigin: true }));
app.use('/transactions', proxy.createProxyMiddleware({ target: 'http://localhost:4002', changeOrigin: true }));
app.use('/notifications', proxy.createProxyMiddleware({ target: 'http://localhost:4003', changeOrigin: true }));
app.use('/audit', proxy.createProxyMiddleware({ target: 'http://localhost:4004', changeOrigin: true }));

app.listen(PORT, () => console.log(`API Gateway running on port ${PORT}`));
