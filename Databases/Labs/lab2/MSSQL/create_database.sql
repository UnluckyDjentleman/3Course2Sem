create table ROLES(
	roleId uniqueidentifier primary key not null,
	roleName varchar(20) not null
);

create table USERS(
	userId uniqueidentifier primary key not null,
	name varchar(50) not null,
	surname varchar(50) not null,
	email varchar(50) not null unique,
	roleId uniqueidentifier foreign key references ROLES(roleId) not null,
	password varchar(32) not null
);



create table CATEGORIES(
	categoryId uniqueidentifier primary key not null,
	categoryName varchar(100) not null
);

create table COUNTRIES(
	countryId char(2) primary key not null,
	countryName varchar(30) not null
);

create table CITIES(
	cityId char(3) primary key not null,
	cityName varchar(30) not null,
	countryId char(2) foreign key references COUNTRIES(countryId) not null,
);

create table HOTELS(
	hotelId uniqueidentifier primary key not null,
	hotelName varchar(40) not null,
	cityId char(3) foreign key(cityId) references CITIES(cityId)
);

create table TRANSPORTS(
	transportId uniqueidentifier primary key not null,
	transportName varchar(20) not null
);

create table TOURS(
	tourId uniqueidentifier primary key not null,
	tourName varchar(100) not null,
	countryId char(2) foreign key references COUNTRIES(countryId) not null,
	cityId char(3) foreign key references CITIES(cityId) not null,
	categoryId uniqueidentifier foreign key references CATEGORIES(categoryId) not null,
	description varchar(1000) not null,
	duration int not null,
	costForOnePerson float not null check(costForOnePerson>0),
	average_mark float not null,
	transportId uniqueidentifier foreign key references TRANSPORTS(transportId) not null,
	hotelId uniqueidentifier foreign key references HOTELS(hotelId) not null
);

create table FEEDBACKS(
	feedbackId uniqueidentifier primary key not null,
	userId uniqueidentifier foreign key references USERS(userId) not null,
	tourId uniqueidentifier foreign key references TOURS(tourId) not null,
	mark float not null
);


create table ORDERS(
	orderId uniqueidentifier primary key,
	tourId uniqueidentifier foreign key references TOURS(tourId) not null,
	userId uniqueidentifier foreign key references USERS(userId) not null,
	adultsCount int not null check(adultsCount>0),
	childrenCount int not null check(childrenCount>=0),
	DateStart date not null,
	cost float not null check(cost>0)
);

create table DISCOUNTS(
	discountId uniqueidentifier primary key not null,
	tourId uniqueidentifier foreign key references TOURS(tourId) not null,
	discountValue float not null check(discountValue>0 and discountValue<1)
);