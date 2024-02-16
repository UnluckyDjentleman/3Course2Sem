const {Sequelize}=require('sequelize');

const sequelize=new Sequelize({
    dialect: 'mssql',
    database: 'gvs',
    username: 'gvscore',
    host: 'localhost',
    port: '1433',
    password: '8800'
})

sequelize.authenticate().then(()=>{
    console.log("Connection with database is successful");
    sequelize.close();
}).catch(e=>{
    console.log(`ERROR: ${e}`);
})