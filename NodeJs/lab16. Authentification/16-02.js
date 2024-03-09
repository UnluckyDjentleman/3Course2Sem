const fs=require('fs');
const express=require('express');
const app=express();
const passport=require('passport');
const DigestStrategy=require('passport-http').DigestStrategy;
const accounts=JSON.parse(fs.readFileSync('accounts.json'));
const session=require('express-session')(
    {
        resave: false,
        saveUninitialized: false,
        secret: 'qwertyui'
    }
);
app.use(session);
app.use(passport.session())
app.use(passport.initialize());
passport.use(new DigestStrategy({gop: 'auth'},(user, done)=>{
    let rc=null;
    let cr=getCredentials(user)
    if(!cr){
        rc=done(null,false)
    }
    else{
        rc=done(null, cr.user, cr.password)
    }
}, (params, done)=>{
    console.log('params'+params);
    done(null, true);
}))

app.get('/', (req, res)=>{
    res.redirect('/login');
})
app.get('/login', (req, res, next) => {
    if (req.session.logout) {
        req.session.logout = false;
        delete req.headers['authorization'];
    }
    next();
}).get('/login', passport.authenticate('digest', {session: false}),(req, res)=>{
    res.redirect('/resource')
})

app.get('/logout',(req,res)=>{
    req.session.logout=true;
    res.redirect('/');
}).get('/resource',(req,res)=>{
    req.headers['authorization']?res.send('SUPER SOURCE'):res.redirect('/');
})
app.get('*',(req,res)=>{
    res.status(404).send('ERROR 404: Not Found!!!!');
})
app.listen(3000, ()=>console.log('App is listening at http://localhost:3000'));








//=============================
const verifyPassword=(passw1, passw2)=>{
    return passw1===passw2;
}

const getCredentials=(elem)=>{
    return accounts.find(acc=>{
        return acc.user.toUpperCase()===elem.toUpperCase();
    })
}