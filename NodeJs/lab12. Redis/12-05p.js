const redis=require("redis");

const client=new redis.createClient({url: "redis://localhost:6379"});

client.on('connect',()=>console.log("Success!!!"));
client.on('error', err=>console.log("Error!!! "+err));
client.on('ready', ()=>console.log("Publisher is ready for work!"));
client.on('end', ()=>"Client disconnected");

client.connect();
client.publish('MyChannel','Hello World');
