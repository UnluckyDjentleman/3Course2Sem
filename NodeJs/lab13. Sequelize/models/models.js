const {Sequelize, Op, DataTypes}=require('sequelize');

const sequelize=new Sequelize('gvs','gvscore','8800',{
    host:'localhost',
    dialect:'mssql',
    define: { 
        timestamps: false 
    },
    pool: {
        max: 10,
        min: 1,
        idle: 10000
    }
})

const auditorium_type=sequelize.define(
    'AUDITORIUM_TYPE',
    {
        AUDITORIUM_TYPE:{
            type: DataTypes.CHAR(10),
            allowNull: false,
            primaryKey: true
        },
        AUDITORIUM_TYPENAME:{
            type: DataTypes.STRING(30)
        }
    },
    {
        sequelize,
        tableName: "AUDITORIUM_TYPE"
    }
);

const auditorium=sequelize.define(
    'AUDITORIUM',
    {
        AUDITORIUM:{
            type: DataTypes.CHAR(20),
            allowNull: false,
            primaryKey: true
        },
        AUDITORIUM_CAPACITY:{
            type: DataTypes.INTEGER,
            allowNull: false
        },
        AUDITORIUM_NAME:{
            type: DataTypes.STRING(50),
            allowNull: false
        }
    },
    {
        sequelize,
        tableName: "AUDITORIUM",
        scopes:{
            moreThan60:{
                where:{
                    AUDITORIUM_CAPACITY: {
                        [Op.gt]:60
                    }
                }
            },
            from10To60:{
                where:{
                    AUDITORIUM_CAPACITY:{
                        [Op.between]: [10,60],
                    }
                }
            }
        }
    }
);

auditorium_type.hasMany(
    auditorium,
    {
        foreignKey:"AUDITORIUM_TYPE",
        sourceKey: "AUDITORIUM_TYPE"
    }
);

const faculty=sequelize.define(
    "FACULTY",
    {
        FACULTY:{
            type: DataTypes.CHAR(10),
            allowNull: false,
            primaryKey: true
        },
        FACULTY_NAME:{
            type: DataTypes.STRING(50),
        }
    },
    {
        sequelize,
        tableName:"FACULTY",
        hooks:{
            beforeCreate:(fac, options)=>{console.log(`It's beforeCreate hook: ${fac.dataValues}`)},
            afterCreate:(fac, options)=>{console.log(`It's afterCreate hook: ${fac.dataValues}`)}
        }
    }
);

const pulpit=sequelize.define(
    "PULPIT",
    {
        PULPIT:{
            type: DataTypes.CHAR(20),
            allowNull: false,
            primaryKey: true
        },
        PULPIT_NAME:{
            type: DataTypes.STRING(100)
        }
    },
    {
        sequelize,
        tableName:"PULPIT"
    }
);

faculty.hasMany(
    pulpit,
    {
        foreignKey:'FACULTY',
        sourceKey:'FACULTY'
    }
)

const subject=sequelize.define(
    "SUBJECT",
    {
        SUBJECT:{
            type: DataTypes.CHAR(20),
            allowNull: false,
            primaryKey: true
        },
        SUBJECT_NAME:{
            type: DataTypes.STRING(100)
        }
    },
    {
        sequelize,
        tableName:"SUBJECT"
    }
);

const teacher=sequelize.define(
    "TEACHER",
    {
        TEACHER:{
            type: DataTypes.CHAR(20),
            allowNull: false,
            primaryKey: true
        },
        TEACHER_NAME:{
            type: DataTypes.STRING(100)
        }
    },
    {
        sequelize,
        tableName:"TEACHER"
    }
);

pulpit.hasMany(
    subject,
    {
        foreignKey:'PULPIT',
        sourceKey:'PULPIT'
    }
);

pulpit.hasMany(teacher, {
    foreignKey: 'PULPIT',
    sourceKey: 'PULPIT'
});

module.exports={auditorium,auditorium_type,pulpit,subject,faculty, teacher};
