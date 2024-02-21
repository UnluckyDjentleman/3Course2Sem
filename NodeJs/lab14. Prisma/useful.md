# How to generate Prisma Objects?
1. ## Installation and Initialization
Installation:

```
npm install prisma
```

Initialization:

```
npx prisma init
```

After that files __.env__ and __schema.prisma__ will be generated;

2. ## Connection
Then change __"DATABASE_URL"__ in __.env__ file. Also in __schema.prisma__ change the field __provider__ to the database you use. 

To pull data and table from your database:

```
npx prisma db pull
```

## GOOD LUCK!!!





