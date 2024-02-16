const redis=require("redis");

const client=new redis.createClient({url: "redis://localhost:6379"});

client.on('connect',()=>console.log("Success!!!"));
client.on('error', err=>console.log("Error!!! "+err));
client.on('ready', ()=>console.log("Client is ready for work!"));
client.on('end', ()=>"Client disconnected");


const RedisTime = async ()=>{

    await client.connect();
    //------SET--------
    const time1=Date.now();
    for(let i=1;i<=10000;i++){
        await client.set(i.toString(),`set${i}`);
    }
    console.log(`10000 SET Queries Speed: ${Date.now()-time1}`)

    //------GET--------
    console.time("10000 GET Queries Speed ");
    for(let i=1;i<=10000;i++){
        await client.get(i.toString());
    }
    console.timeEnd("10000 GET Queries Speed ")

    ////------DEL--------
    console.time("10000 DEL Queries Speed ");
    for(let i=1;i<=10000;i++){
        await client.del(i.toString());
    }
    console.timeEnd("10000 DEL Queries Speed ")

    await client.quit();
}

RedisTime();