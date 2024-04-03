const http=require("http");
const url=require("url");
const fs=require('fs');
const app=require('express')();
const {parse}=require('querystring');

/*http.createServer((req,res)=>{
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
            setTimeout(()=>{
                res.end(res.getHeader('X-Value-z').toString())
            },10000)
        })
    }
    else if(req.method==='GET'){
        res.end(fs.readFileSync('form.html'));
    }
}).listen(8082,()=>console.log('Running at http://localhost:8082'));*/

app.get('/',(req,res)=>{
    res.end(fs.readFileSync('form.html'));
})

app.post('/first',(req,res)=>{
    var x=parseInt(req.headers['x-value-x'])||0;
    var y=parseInt(req.headers['x-value-y'])||0;
    var z=x+y;
    console.log(z);
    res.setHeader('X-Value-z', z)
    setTimeout(()=>{
        res.send(res.getHeader('X-Value-z').toString())
    },10000)
});

app.post('/second',(req,res)=>{
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
    setTimeout(()=>{
        res.send(JSON.stringify(arr));
    },1000)
});

app.listen(8082);