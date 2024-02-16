const {Sequelize, Op, DataTypes}=require('sequelize');
const express = require('express');
const SequelizeFunc = require('./functionality/func');
const app=express();
const pref='/api';

const seq=new SequelizeFunc();

const sequelize=new Sequelize('gvs','gvscore','8800',{
    host:'localhost',
    dialect:'mssql',
    define: {
        timestamps: false,
        hooks: {
            beforeDestroy() { console.log('s') }
        }
    },
    pool: {
        max: 10,
        min: 1,
        idle: 10000
    }
})

app.use(express.json());
app.use(express.static('static'));
app.get("/",(req,res)=>{
    res.sendFile("D:\\Sem32\\NodeJS\\lab13. Sequelize\\static\\mainPage.html");
});

app.get(pref+"/faculties",(req,res)=>{
    seq.getAllFaculties(res);
}).get(pref+"/subjects",(req,res)=>{
    seq.getAllSubjects(res);
}).get(pref+"/pulpits",(req,res)=>{
    seq.getAllPulpits(res);
}).get(pref+"/teachers",(req,res)=>{
    seq.getAllTeachers(res);
}).get(pref+"/auditoriums",(req,res)=>{
    seq.getAuditoriums(res);
}).get(pref+"/auditoriumtypes",(req,res)=>{
    seq.getAuditoriumTypes(res);
}).get(pref+'/auditoriumtypes/:xyz/auditoriums',(req,res)=>{
    seq.getAuditoriumTypes(res, req.param['xyz']);
}).get(pref+'/faculties/:xyz/subjects',(req,res)=>{
    seq.getFacultySubjects(res, req.param['xyz']);
}).get(pref+'/audi60', (req,res)=>{
    seq.getAud60(res);
})
.get(pref+'/audi1060', (req,res)=>{
    seq.getAud10to60(res);
}).get(pref+'/trans', (req,res)=>{
    seq.SequelizeFunc.transaction(res);
});

app.post(pref+"/faculties",(req,res)=>{
    seq.postFaculty(res, req.body);
}).post(pref+"/subjects",(req,res)=>{
    seq.postSubject(res, req.body);
}).post(pref+"/pulpits",(req,res)=>{
    seq.potPulpit(res, req.body);
}).post(pref+"/teachers",(req,res)=>{
    seq.postTeacher(res, req.body);
}).post(pref+"/auditoriums",(req,res)=>{
    seq.postAuditorium(res, req.body);
}).post(pref+"/auditoriumtypes",(req,res)=>{
    seq.postAuditoriumType(res, req.body);
});

app.put(pref+"/faculties",(req,res)=>{
    seq.putFaculty(res, req.body);
}).put(pref+"/subjects",(req,res)=>{
    seq.putSubject(res, req.body);
}).put(pref+"/pulpits",(req,res)=>{
    seq.putPulpit(res, req.body);
}).put(pref+"/teachers",(req,res)=>{
    seq.putTeacher(res, req.body);
}).put(pref+"/auditoriums",(req,res)=>{
    seq.putAuditorium(res, req.body);
}).put(pref+"/auditoriumtypes",(req,res)=>{
    seq.putAuditoriumType(res, req.body);
});

app.delete(pref+"/faculties/:xyz",(req,res)=>{
    seq.deleteFaculty(res, req.params["xyz"]);
}).delete(pref+"/subjects/:xyz",(req,res)=>{
    seq.deleteSubject(res, req.params["xyz"]);
}).delete(pref+"/pulpits/:xyz",(req,res)=>{
    seq.deletePulpit(res, req.params["xyz"]);
}).delete(pref+"/teachers/:xyz",(req,res)=>{
    seq.deleteTeacher(res, req.params["xyz"]);
}).delete(pref+"/auditoriums/:xyz",(req,res)=>{
    console.log(req.params["xyz"]);
    seq.deleteAuditorium(res, req.params["xyz"]);
}).delete(pref+"/auditoriumtypes/:xyz",(req,res)=>{
    seq.deleteAuditoriumType(res, req.params["xyz"]);
});

sequelize.authenticate().then(()=>{
    console.log("Connection with database is successful");
}).catch(e=>{
    console.log(`ERROR: ${e}`);
    sequelize.close();
})

app.listen(3000);