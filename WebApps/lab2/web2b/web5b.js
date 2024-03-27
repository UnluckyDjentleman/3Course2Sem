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
            var n=parseInt(req.headers['x-rand-n'])||0;
            console.log(n);
            let arr=[];
            let length=Math.floor(Math.random()*5)+5;
            console.log('Length: '+length);
            for(let i=0;i<length;i++){
                let num=Math.floor(Math.random()*(2*n))-n;
                console.log('Element'+i+': '+num);
                arr.push(num);
            }
            console.log(arr);
            res.end(JSON.stringify(arr,null,2));
        })
    }
    else if(req.method==='GET'){
        res.end(fs.readFileSync('form.html'));
    }
}).listen(8086,()=>console.log('Running at http://localhost:8086'));