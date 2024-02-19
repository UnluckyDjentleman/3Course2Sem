alter session set "_ORACLE_SCRIPT"=true;

create table ROLES(
	 roleId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     roleName VARCHAR2(20) NOT NULL
);

create table USERS(
	userId number generated always as identity primary key not null,
	name varchar(50) not null,
	surname varchar(50) not null,
	email varchar(50) not null unique,
	roleId number,
	password varchar(32) not null,
    constraint fk_role foreign key(roleId) references ROLES(roleId)
);



create table CATEGORIES(
	categoryId number generated always as identity primary key not null,
	categoryName varchar2(100) not null
);

create table COUNTRIES(
	countryId char(2) primary key not null,
	countryName varchar2(30) not null
);

create table CITIES(
	cityId char(3) primary key not null,
	cityName varchar2(30) not null,
	countryId char(2),
    constraint fk_city foreign key(countryId) references COUNTRIES(countryId)
);

create table HOTELS(
	hotelId number generated always as identity primary key not null,
	hotelName varchar(40) not null,
	cityId char(3),
    constraint fk_hotel foreign key(cityId) references CITIES(cityId)
);

create table TRANSPORTS(
	transportId number generated always as identity primary key not null,
	transportName varchar(20) not null
);

create table TOURS(
	tourId number generated always as identity primary key not null,
	tourName varchar(100) not null,
	countryId char(2) not null,
	cityId char(3) not null,
	categoryId number not null,
	description varchar(1000) not null,
	duration number not null,
	costForOnePerson number(10,2) not null check(costForOnePerson>0),
	average_mark number(10,2) not null,
	transportId number not null,
	hotelId number not null,
    constraint fk_country_tours foreign key(countryId) references COUNTRIES(countryId),
    constraint fk_city_tours foreign key(cityId) references CITIES(cityId),
    constraint fk_category_tours foreign key(categoryId) references CATEGORIES(categoryId),
    constraint fk_transport_tours foreign key(transportId) references TRANSPORTS(transportId),
    constraint fk_hotel_tours foreign key(hotelId) references HOTELS(hotelId)
);

create table FEEDBACKS(
	feedbackId number generated always as identity primary key not null,
	userId number,
	tourId number,
	mark number(10,2) not null,
    constraint fk_feed_user foreign key(userId) references USERS(userId),
    constraint fk_feed_tour foreign key(tourId) references TOURS(tourId)
);

create table ORDERS(
	orderId number generated always as identity primary key,
	tourId number,
	userId number,
	adultsCount number not null check(adultsCount>0),
	childrenCount number not null check(childrenCount>=0),
	DateStart date not null,
	cost number(10,2) not null check(cost>0),
    constraint fk_order_tours foreign key(tourId) references TOURS(tourID),
    constraint fk_order_users foreign key(userId) references USERS(userId)
);

create table DISCOUNTS(
	discountId number generated always as identity primary key not null,
	tourId number,
	discountValue number(10,2) not null check(discountValue>0 and discountValue<1),
    constraint fk_discount_tours foreign key(tourId) references TOURS(tourId)
);

select * from ROLES;

drop table ROLES;
drop table USERS;
drop table HOTELS;
drop table CATEGORIES;
drop table TRANSPORTS;
drop table ORDERS;
drop table CITIES;
drop table COUNTRIES;
drop table FEEDBACKS;
drop table TOURS;
drop table DISCOUNTS;
commit;