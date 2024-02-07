const redis=require("redis");

const client=new redis.createClient({url: "redis://localhost:6379"});

client.on('connect',()=>console.log("Success!!!"));
client.on('error', err=>console.log("Error!!! "+err));
client.on('ready', ()=>console.log("Client is ready for work!"));
client.on('end', ()=>"Client disconnected");

const RedisTimeHsetHget=async ()=>{
    await client.connect();
    await client.set('incr',0);

    //--------HSET-----------
    console.time("10000 HSET Queries Speed ")
    for(let i=1;i<=10000;i++){
        await client.hSet(`hash${i}`,i.toString(),`{id:${i}, val: "val-${i}"}`);
    }
    console.timeEnd("10000 HSET Queries Speed ");
    //--------HGET-----------
    console.time("10000 HGET Queries Speed ")
    for(let i=1;i<=10000;i++){
        await client.hGet(`hash${i}`,i.toString());
    }
    console.timeEnd("10000 HGET Queries Speed ");

    await client.quit();
}

RedisTimeHsetHget();