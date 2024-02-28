const fs=require('fs');
const port=3000;
const bodyParser=require('body-parser')
const express=require('express');
const { addContactMethod, getAllContacts, updateContactMethod, deleteContactMethod, getForUpdate, getForInsert } = require('./enterprise');
const hbs=require('express-handlebars').create({
    extname:'.hbs',
    helpers:{
        dismiss: ()=>{
            return '<button type="button" class="btn btn-link" style="width:20%; margin:1.5%" onclick="window.location.href=\'http://localhost:3000/\'">Deny</button>'
        }
    }
});
const app=express();
const resp=JSON.parse(fs.readFileSync("contacts.json"));
console.log(resp);

app.engine('hbs', hbs.engine);
app.use(express.static('static'));
app.use(bodyParser.json());
app.use(express.json());
app.set('view engine','.hbs');

app.get('/',(request, response)=>{
    getAllContacts(response)
});

app.get('/add',(request,response)=>{
    getForInsert(response);
})

app.get('/update/:id', (request, response)=>{
    getForUpdate(request, response)
})

app.post('/add', (request, response)=>{
    addContactMethod(request.body).then(response.redirect('/'));
})

app.post('/update/:id', (request,response)=>{
    updateContactMethod(request).then(response.redirect('/'));
})

app.post('/delete/:id', (request,response)=>{
    deleteContactMethod(request).then(response.redirect('/'));
})

app.listen(port, () => {
    console.log('Server is running on port '+port);
});
