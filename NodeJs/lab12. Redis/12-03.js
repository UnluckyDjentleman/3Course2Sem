const redis=require("redis");

const client=new redis.createClient({url: "redis://localhost:6379"});

client.on('connect',()=>console.log("Success!!!"));
client.on('error', err=>console.log("Error!!! "+err));
client.on('ready', ()=>console.log("Client is ready for work!"));
client.on('end', ()=>"Client disconnected");

const RedisTimeIncrDecr = async ()=>{
    await client.connect();
    await client.set('incr',0);

    //-------INCR-------
    console.time("10000 INCR Queries Speed ")
    for(let i=1;i<=10000;i++){
        await client.incr('incr');
    }
    console.timeEnd("10000 INCR Queries Speed ");
    //-------DECR------
    console.time("10000 DECR Queries Speed ")
    for(let i=1;i<=10000;i++){
        await client.decr('incr');
    }
    console.timeEnd("10000 DECR Queries Speed ");

    await client.quit();
}

RedisTimeIncrDecr();