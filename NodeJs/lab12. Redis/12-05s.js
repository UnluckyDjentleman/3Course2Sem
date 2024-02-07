const redis=require("redis");

const client=new redis.createClient({url: "redis://localhost:6379"});

client.on('connect',()=>console.log("Success!!!"));
client.on('error', err=>console.log("Error!!! "+err));
client.on('ready', ()=>console.log("Subscriber is ready for work!"));
client.on('end', ()=>"Client disconnected");

client.connect();
client.subscribe('*',(message, channel)=>{
    console.log(`Received message from channel ${channel}: ${message}`);
});