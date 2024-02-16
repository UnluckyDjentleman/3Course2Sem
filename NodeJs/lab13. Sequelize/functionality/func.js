const {Sequelize, Op, Transaction}=require('sequelize');
const auditoriumq=require('../models/models').auditorium;
const auditoriumTypeq=require('../models/models').auditorium_type;
const teacherq=require('../models/models').teacher;
const pulpitq=require('../models/models').pulpit;
const subjectq=require('../models/models').subject;
const facultyq=require('../models/models').faculty;

const sequelize=new Sequelize('gvs','gvscore','8800',{
    host:'localhost',
    dialect:'mssql',
    define: {
        timestamps: false,
        hooks: {
            beforeDestroy() { console.log('beforeDestroy called') }
        }
    },
    pool: {
        max: 10,
        min: 1,
        idle: 10000
    }
});

class SequelizeFunc{
    //=======================select
    getAllFaculties=async res=>{
        res.json(await facultyq.findAll());
    }
    getAllPulpits=async res=>{
        res.json(await pulpitq.findAll());
    }
    getAllSubjects=async res=>{
        res.json(await subjectq.findAll());
    }
    getAllTeachers=async res=>{
        res.json(await teacherq.findAll());
    }
    getAuditoriums=async res=>{
        res.json(await auditoriumq.findAll());
    }
    getAuditoriumTypes=async res=>{
        res.json(await auditoriumTypeq.findAll());
    }
    getAuditoriumsAudTypes=async (res,audtId)=>{
        try{
            const audType=await auditoriumTypeq.findByPk(audtId);
            const auditoriums=await auditoriumq.findAll({where: audtId});
            if(!audType){
                res.status(404).json({code: 404, message:`xdxdxd`})
            }
            else if(!auditoriums){
                res.status(404).json({code: 404, message:`pulpits with faculty ${audtId} don't exist`});
            }
            else{
                res.json(await auditoriumTypeq.findAll(
                    {
                        where: {auditorium_type: audtId},
                        include:{
                            model: auditoriumq,
                            attributes:['AUDITORIUM','AUDITORIUM_NAME', 'AUDITORIUM_CAPACITY']
                        }
                    }         
                ))
            }
        }
        catch(e){
            console.log('ERROR detected: '+e.message);
        }
    }
    getFacultySubjects=async (res,xyz)=>{
        try{
            const neededFaculty=await facultyq.findByPk(xyz);
            if(!neededFaculty){
                res.status(404).json({code: 404, message:`xdxdxd`})
            }
            else if(!searchTeachers){
                res.status(404).json({code: 404, message:`xdxdxdteacher`})
            }
            else{
                res.json(await facultyq.findAll(
                    {
                        where: {FACULTY: facId},
                        include:{
                            model: pulpitq,
                            attributes:['PULPIT','PULPIT_NAME'],
                            include:{
                                model: subjectq,
                                attributes:['SUBJECT','SUBJECT_NAME']
                            }
                        }
                    }         
                ))
            }
        }
        catch(e){
            console.log('ERROR detected: '+e.message);
        }
    }

    getAud60=async res=>{
        const audi60=await facultyq.scope('moreThan60').findAll();
        (audi60.length!=0)?res.json(audi60):res.status(404).json({code: 404, message:`xdxdxd60`})
    }
    getAud10to60=async res=>{
        const audi1060=await facultyq.scope('from10to60').findAll();
        (audi1060.length!=0)?res.json(audi1060):res.status(404).json({code: 404, message:`xdxdxd1060`})
    }
    //==================insert
    postAuditorium=async (res, data)=>{
        res.json(await auditoriumq.create(data));
    }
    postAuditoriumType=async (res,data)=>{
        res.json(await auditoriumTypeq.create(data));
    }
    postFaculty=async (res,data)=>{
        res.json(await facultyq.create(data));
    }
    postSubject=async (res,data)=>{
        res.json(await subjectq.create(data));
    }
    postTeacher=async (res,data)=>{
        res.status(201).json(await teacherq.create(data));
    }
    postPulpit=async (res,data)=>{
        res.json(await pulpitq.create(data));
    }
    //===================update
    putAuditorium=async (res, data)=>{
        const audById=await auditoriumq.findByPk(data.AUDITORIUM);
        if(!audById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await auditoriumq.update(data, {where:{AUDITORIUM: data.AUDITORIUM}}).then(async ()=>{
            await res.json(await auditoriumq.findByPk(data.AUDITORIUM))
        })
    }
    putAuditoriumType=async (res,data)=>{
        const audTById=await auditoriumTypeq.findByPk(data.AUDITORIUM_TYPE);
        if(!audTById){
            res.status(404).json({code: 404, message:`xdxdxdaudT`});
        }
        await auditoriumTypeq.update(data, {where:{AUDITORIUM_TYPE: data.AUDITORIUM_TYPE}}).then(async ()=>{
            await res.json(await auditoriumTypeq.findByPk(data.AUDITORIUM_TYPE))
        })
    }
    putFaculty=async (res,data)=>{
        const facById=await facultyq.findByPk(data.FACULTY);
        if(!facById){
            res.status(404).json({code: 404, message:`xdxdxdaudT`});
        }
        await facultyq.update(data, {where:{FACULTY: data.FACULTY}}).then(async ()=>{
            await res.json(await facultyq.findByPk(data.FACULTY))
        })
    }
    putSubject=async (res,data)=>{
        const subjById=await subjectq.findByPk(data.SUBJECT);
        if(!subjById){
            res.status(404).json({code: 404, message:`xdxdxdaudT`});
        }
        await subjectq.update(data, {where:{SUBJECT: data.SUBJECT}}).then(async ()=>{
            await res.json(await subjectq.findByPk(data.SUBJECT))
        })
    }
    putTeacher=async (res,data)=>{
        const teacherById=await teacherq.findByPk(data.TEACHER);
        if(!teacherById){
            res.status(404).json({code: 404, message:`xdxdxdaudT`});
        }
        await teacherq.update(data, {where:{TEACHER: data.TEACHER}}).then(async ()=>{
            await res.json(await teacherq.findByPk(data.TEACHER))
        })
    }
    putPulpit=async (res,data)=>{
        const subjById=await pulpitq.findByPk(data.PULPIT);
        if(!subjById){
            res.status(404).json({code: 404, message:`xdxdxdaudT`});
        }
        await pulpitq.update(data, {where:{PULPIT: data.PULPIT}}).then(async ()=>{
            await res.json(await pulpitq.findByPk(data.PULPIT))
        })
    }
    //======================delete
    deleteAuditorium=async (res, xyz)=>{
        const audById=await auditoriumq.findByPk(xyz);
        if(!audById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await auditoriumq.destroy({where: {AUDITORIUM: xyz}}).then(
            ()=>{
                if(!audById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(audById)
            }
        )
    }
    deleteAuditoriumType=async (res,xyz)=>{
        const audTById=await auditoriumTypeq.findByPk(xyz);
        if(!audTById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await auditoriumTypeq.destroy({where: {AUDITORIUM_TYPE: xyz}}).then(
            ()=>{
                if(!audTById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(audTById)
            }
        )
    }
    deleteFaculty=async (res,xyz)=>{
        const facById=await facultyq.findByPk(xyz);
        if(!facById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await facultyq.destroy({where: {FACULTY: xyz}}).then(
            ()=>{
                if(!facById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(facById)
            }
        )
    }
    deleteSubject=async (res,xyz)=>{
        const subjById=await subjectq.findByPk(xyz);
        if(!subjById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await subjectq.destroy({where: {SUBJECT: xyz}}).then(
            ()=>{
                if(!subjById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(subjById)
            }
        )
    }
    deleteTeacher=async (res,xyz)=>{
        const teacherById=await teacherq.findByPk(xyz);
        console.log(JSON.stringify(teacherById));
        if(!teacherById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await teacherq.destroy({where: {TEACHER: xyz}}).then(
            ()=>{
                if(!teacherById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(teacherById)
            }
        )
    }
    deletePulpit=async (res,xyz)=>{
        const pulpById=await pulpitq.findByPk(xyz);
        if(!pulpById){
            res.status(404).json({code: 404, message:`xdxdxdaud`});
        }
        await pulpitq.destroy({where: {PULPIT: xyz}}).then(
            ()=>{
                if(!pulpById){
                    res.status(404).json({code: 404, message:`xdxdxdaud`});
                }
                res.json(pulpById)
            }
        )
    }
    //=======================transaction
    transaction=async(res)=>{
        sequelize.transaction(
            {
                isolationLevel: Transaction.ISOLATION_LEVELS.READ_UNCOMMITTED
            }
        ).then(
            transact=>{
                auditoriumq.update(
                    {where:{AUDITORIUM_CAPACITY: 0}},
                    {
                        where:{AUDITORIUM_CAPACITY:{
                            [Op.gte]:0
                        }},
                        transaction: transact
                    }
                ).then(()=>
                    {
                        res.json({'message':'u'});
                        console.log('Wait...');
                        setTimeout(()=>{
                            transact.rollback();
                            console.log("Rollbacked");
                        },10000);
                    }
                ).catch(e=>console.log(e));
            }
        ).catch(()=>console.log(e));
    }
};

module.exports=SequelizeFunc;