const express=require('express');
const app=express();
const {Strategy}=require("passport-github2");
const session=require('express-session');
const passport=require('passport')
const {Sequelize, DataTypes}=require('sequelize');
const { ISOLATION_LEVEL } = require('tedious');
const sequelize=new Sequelize({
    dialect: 'mssql',
    database: 'githubaccs',
    username: 'gvscore',
    host: 'localhost',
    port: '1433',
    password: '8800',
    pool: {
        max: 10,
        min: 1,
        idle: 10000
    }
});
sequelize.authenticate().then(()=>{
    console.log('Connection with database is successful');
}).catch(e=>{
    console.log(e.message);
})
const users=sequelize.define(
    'USERS',
    {
        id:{
            type: DataTypes.STRING(50), 
            primaryKey: true,
        },
        username:{
            type: DataTypes.STRING(100),
        }
    },
    {
        sequelize,
        tableName:"USERS",
        timestamps: false
    }
);

app.use(session({ secret: 'secret', resave: false, saveUninitialized: false }));
app.use(express.urlencoded({ extended: true }));
app.use(passport.initialize());
app.use(passport.session());
passport.serializeUser(function (user, done) { done(null, user); });
passport.deserializeUser(function (user, done) { done(null, user); });
require('dotenv').config();
console.log(process.env.CLIENTID);
console.log(process.env.CLIENTSECRET)


passport.use(
    new Strategy(
        {
            clientID: process.env.CLIENTID,
            clientSecret: process.env.CLIENTSECRET,
            callbackURL: 'http://localhost:8084/auth/github/callback',
        },
        async function (accessToken, refreshToken, profile, done) {
            try{
                let user=await users.findByPk(profile.id);
                if(!user){
                    user=await users.create({
                        id: profile.id,
                        username: profile.username
                    })
                }
                done(null, user);
            }
            catch(e){
                console.error(e);
                return done(e,null);
            }
        }
    )
)

app.get('/login',(req,res)=>{
    res.sendFile(__dirname+'/static/htmlina.html');
});
app.get('/auth/github',passport.authenticate(
    'github',{ scope: [ 'user:email' ] }
));
app.get('/auth/github/callback',passport.authenticate(
    'github',{
        failureRedirect:'/login',
    }
),
(req,res)=>{
    res.redirect('/resource')
});
app.get('/logout',(req,res)=>{
    req.logout(()=>{
        res.redirect('/login')
    })
})
app.get('/resource',(req,res)=>{
    if(req.isAuthenticated()){
        return res.send(`Welcome,${req.user.username}`);
    }
    return res.status(401).end('401 Unauthorized');
})

app.listen(8084,()=>{
    console.log('http://localhost:8084/login');
})