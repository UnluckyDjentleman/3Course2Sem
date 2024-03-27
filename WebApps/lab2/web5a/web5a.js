const http=require("http");
const url=require("url");
const fs=require('fs');
const {parse}=require('querystring');

http.createServer((req,res)=>{
    if(req.method==='POST'){
        let data='';
        req.on('data',chunk=>{
            data+=chunk.toString();
        });
        req.on('end',()=>{
            var x=parseInt(req.headers['x-value-x'])||0;
            var y=parseInt(req.headers['x-value-y'])||0;
            var z=x+y;
            console.log(z);
            res.setHeader('X-Value-z', z)
            res.end(res.getHeader('X-Value-z').toString())
        })
    }
    else if(req.method==='GET'){
        res.end(fs.readFileSync('form.html'));
    }
}).listen(8082,()=>console.log('Running at http://localhost:8082'));