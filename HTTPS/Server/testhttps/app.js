const Koa = require('koa');
const https = require('https');
const fs = require('fs');
const router = require('koa-router')();

const app = new Koa();

//路由
router.get('/', (ctx, next) => {
    ctx.response.body = '这是一个简单的节点js https服务器响应';
})
app.use(router.routes());

//https
// 第一种服务端使用自签名证书,单向验证
// https.createServer({
//     key: fs.readFileSync('./server-private-key.pem'),
//     cert: fs.readFileSync('./server-cert.pem'),
// }, app.callback()).listen(3000);
//  第二种服务端使用自签名证书,双向验证
https.createServer({
    key: fs.readFileSync('./server-private-key.pem'),
    cert: fs.readFileSync('./server-cert.pem'),
    requestCert: true, // 表示客户端需要证书
    ca:[fs.readFileSync('./client-cert.pem')]  //用于匹配客户端证书
}, app.callback()).listen(3000);

console.log(`https app started at port 3000`)
