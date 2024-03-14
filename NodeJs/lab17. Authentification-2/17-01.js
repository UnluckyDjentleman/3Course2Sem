const express=require('express');
var crypto = require('crypto');
const uuid = require('node-uuid');
const passport=require('passport');
const localStrategy=require("passport-local").Strategy;
const fs=require('fs');
const cp=require('cookie-parser')

const app=express();
//app.use(cp());
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static(__dirname+'/static'));
app.use(require('express-session')({
    genid: function(req){
        console.log(`Session ID:${req.sessionID}`);
        return uuid.v4();
    },
    resave: false,
    saveUninitialized: false,
    secret: 'qwerty'
}));
app.use(passport.session());
app.use(passport.initialize());

passport.use(new localStrategy((username, password, done)=>{
    const accounts=JSON.parse(fs.readFileSync('accounts.json'));
    console.log(accounts);
    const index=accounts.findIndex(elem=>elem.nickname===username);
    const user=accounts[index];
    if(index===-1){
        console.log('Not found User')
        return done(null,false,{
            message:'User is not found'
        })
    }
    else if(user.password!==password){
        console.log('Wrong password')
        return done(null,false,{
            message:'wrong password'
        })
    }
    console.log('Success!!!!')
    return done(null, user);
}));
passport.serializeUser((user, done)=>{
    done(null, user);
})
passport.deserializeUser((user, done)=>{
    done(null, user);
})

app.get('/',(req,res)=>{
    res.redirect('/login');
})
app.get('/login',(req,res)=>{
    res.sendFile(__dirname+'/static/login.html');
})
app.post('/login',(req,res,next)=>{
    console.log('params',req.body)
    next()
},passport.authenticate(
    'local',
    {
        successRedirect:'/resource',
        failureRedirect:'/login'
    }
));
app.get('/logout', (req,res,next)=>{
    req.session.logout=true;
    res.redirect('/');
}).get('/resource',(req,res)=>{
    console.log(`Resource Session ID: ${req.sessionID}`);
    if(!req.user){
        res.status(401).send('<h2>ERROR 401: Unauthorized</h2>')
    }
    res.send(`<h2>Hello, ${req.user.nickname}</h2>`)
});

app.listen(3000, ()=>console.log('Listening to http://localhost:3000'));

