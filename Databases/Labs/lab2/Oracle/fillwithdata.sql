insert into COUNTRIES values
('AL','Albania'),
('BR', 'Brazil'),
('CR','Croatia'),
('DK','Denmark'),
('ES','Estonia'),
('FI','Finland'),
('GE','Georgia'),
('HU','Hungary'),
('IN','India'),
('JP','Japan'),
('KN','Kenya'),
('LI','Lithuania'),
('MN','Montenegro'),
('NR', 'Norway'),
('OM','Oman'),
('PR','Portugal'),
('RM','Romania'),
('SP','Spain'),
('TH','Thailand'),
('US','USA'),
('VE','Vietnam'),
('ZI','Zimbabwe');

insert into CITIES values
('TIR','Tirana','AL'),
('RIO','Rio de Janeiro','BR'),
('SAO','Sao Paolo','BR'),
('POR','Porec','CR'),
('PUL','Pula','CR'),
('ZAG','Zagreb','CR'),
('AAR','Aarhus','DK'),
('COP','Copenhagen','DK'),
('TAL','Tallin','ES'),
('NAR','Narva','ES'),
('HEL','Helsinki','FI'),
('ESP','Espoo','FI'),
('JYV','Jyvaskyla','FI'),
('BAT','Batumi','GE'),
('TBI','Tbilisi','GE'),
('FER','Ferencvaros','HU'),
('BUD','Budapest','HU'),
('DUN','Dunajvaros','HU'),
('DEL','New Delhi', 'IN'),
('MUM','Mumbai','IN'),
('TOK','Tokyo','JP'),
('OSA','Osaka','JP'),
('KYO','Kyoto','JP'),
('NAI','Nairobi','KN'),
('KLA','Klaipeda','LI'),
('VIL','Vilnius','LI'),
('POD','Podgorica','MN'),
('CEL','Celine','MN'),
('OSL','Oslo','NR'),
('MAS','Mascat','OM'),
('LIS','Lisboa','PR'),
('BRA','Braga','PR'),
('BUC','Bucharest','RM'),
('CRA','Craiova','RM'),
('MAD','Madrid','SP'),
('BAR','Barcelona','SP'),
('BIL','Bilbao','SP'),
('PHU','Phuket','TH'),
('BAN','Bangkok','TH'),
('NYR','New York','US'),
('CHI','Chicago','US'),
('DAL','Dallas','US'),
('HSM','Ho Chi Minh','VE'),
('HAR','Harare','ZI')

insert into ROLES(roleName) values('Admin'),('User')

select * from roles;

insert into USERS(name, surname, email, roleId, password) values('Liza','Harashchenja','e.goroshchenja@gmail.com',1,'el1z4'),
('Mikhail','Vergeyczyk','mihas.minsi@gmail.com',1,'m1h4$b3g'),
('Artjom','Grynkevic','zjjack@gmail.com',1,'b1azd0nka')

insert into CATEGORIES(categoryName) values('Bussiness'),
('Honeymoon'),
('Health'),
('Family'),
('Sport'),
('Beach'),
('Sightseeing')

select * from CATEGORIES

insert into HOTELS(hotelName,cityId) values ('Panorama','ESP'),
('Sultani','MAS'),
('Umeda','OSA'),
('Crypto','BUC'),
('Parenzo','NAI'),
('Tirana','TIR'),
('LeGoHotel','COP'),
('Golaco','RIO'),
('Kingdom Bernabeo','MAD'),
('Hotel Budapest','BUD')

select * from HOTELS;

insert into TRANSPORTS(transportName) values ('Plane'), ('Bus'), ('Train');

select * from TRANSPORTS;

select * from categories;

insert into TOURS(tourName,countryId,cityId,categoryId,description,duration,costForOnePerson,average_mark,transportId,hotelId) values
('Winter Sport','FI','ESP',5,
'For lovers of active lifestyle and winter. Skiing, swimming, ice hockey. Living in the hotel with panorams where you can look at Aurora.',
7,
340,
0,
1,
1
)
insert into TOURS(tourName,countryId,cityId,categoryId,description,duration,costForOnePerson,average_mark,transportId,hotelId) values(
'Build a Royal House from LEGO','DK','COP',4,
'Cultural Trip with children for LEGO fans. Visit a LEGO Museum and build whatever you want. Also the trip includes sightseeing with guide, visiting a royal house. Living in 5-star hotel.',
10,
2700,
0,
3,
7
)
insert into TOURS(tourName,countryId,cityId,categoryId,description,duration,costForOnePerson,average_mark,transportId,hotelId) values(
'Wildlife','KN','NAI',7,
'Jeep Safari in Nairobi National Park, where you can meet different exotic animals. Mountaineering on volcano Kenya. Visiting the House Museum of Karen Blixen. Living in cosy light hotel',
14,
1800,
0,
1,
5
)
insert into TOURS(tourName,countryId,cityId,categoryId,description,duration,costForOnePerson,average_mark,transportId,hotelId) values(
'Carnaval','BR','RIO',7,
'Colorful RIO!!! Carnaval, dance and sing! Visiting the Jesus Christ Statue and climb it',
15,
2000.0,
0,
1,
8
);

select * from CITIES;

select * from TOURS;
select * from USERS;
select * from ORDERS;

delete from Orders;
delete from DISCOUNTS;
delete from FEEDBACKS;

select * from FEEDBACKS;

insert into DISCOUNTS(tourId, discountValue) values (3,0.3);

select * from ORDERS;