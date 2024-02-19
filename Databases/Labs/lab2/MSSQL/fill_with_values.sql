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
('ZI','Zimbabwe')

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

insert into ROLES values(NEWID(),'Admin'),(NEWID(),'User')

insert into USERS values(NEWID(),'Liza','Harashchenja','e.goroshchenja@gmail.com','C4925041-4F6A-4E0D-9732-E6AC41B3D2D7','el1z4'),
(NEWID(),'Mikhail','Vergeyczyk','mihas.minsi@gmail.com','C4925041-4F6A-4E0D-9732-E6AC41B3D2D7','m1h4$b3g'),
(NEWID(),'Artjom','Grynkevic','zjjack@gmail.com','C4925041-4F6A-4E0D-9732-E6AC41B3D2D7','b1azd0nka')

insert into CATEGORIES values(NEWID(),'Bussiness'),
(NEWID(),'Honeymoon'),
(NEWID(),'Health'),
(NEWID(),'Family'),
(NEWID(),'Sport'),
(NEWID(),'Beach'),
(NEWID(),'Sightseeing')

select * from CATEGORIES

insert into HOTELS values (NEWID(),'Panorama','ESP'),
(NEWID(),'Sultani','MAS'),
(NEWID(),'Umeda','OSA'),
(NEWID(),'Crypto','BUC'),
(NEWID(),'Parenzo','NAI'),
(NEWID(),'Tirana','TIR'),
(NEWID(),'LeGoHotel','COP'),
(NEWID(),'Golaco','RIO'),
(NEWID(),'Kingdom Bernabeo','MAD'),
(NEWID(),'Hotel Budapest','BUD')

select * from HOTELS;

insert into TRANSPORTS values (NEWID(), 'Plane'), (NEWID(), 'Bus'), (NEWID(), 'Train');

select * from TRANSPORTS;

insert into TOURS values
(NEWID(),'Winter Sport','FI','ESP','D15D888F-96CF-4EA0-BFD8-12A02D2D0FBE',
'For lovers of active lifestyle and winter. Skiing, swimming, ice hockey. Living in the hotel with panorams where you can look at Aurora.',
7,
340,
0,
'CA0DB891-3E54-4ECD-B619-EAFA49CAAB7B',
'FB33E506-4560-4A86-8401-E5CA8D275872'
),
(
NEWID(),'Build a Royal House from LEGO','DK','COP','C729CCF7-4F7D-412D-82C6-FA1DCEE30DDF',
'Cultural Trip with children for LEGO fans. Visit a LEGO Museum and build whatever you want. Also the trip includes sightseeing with guide, visiting a royal house. Living in 5-star hotel.',
10,
2700,
0,
'991ff92a-a8e4-4ea0-8df0-cb2083ed4e02',
'17911C7C-3A61-47FC-BEBF-B70673866B4D'
),
(
NEWID(),'Wildlife','KN','NAI','BD123DAA-3CBB-478A-AB8B-9BA22676EA6F',
'Jeep Safari in Nairobi National Park, where you can meet different exotic animals. Mountaineering on volcano Kenya. Visiting the House Museum of Karen Blixen. Living in cosy light hotel',
14,
1800,
0,
'CA0DB891-3E54-4ECD-B619-EAFA49CAAB7B',
'15AA5BBD-E1C8-4D21-85DE-276AB1BAFD5F'
),
(
NEWID(),'Carnaval','BR','RIO','BD123DAA-3CBB-478A-AB8B-9BA22676EA6F',
'Colorful RIO!!! Carnaval, dance and sing! Visiting the Jesus Christ Statue and climb it',
15,
2000,
0,
'CA0DB891-3E54-4ECD-B619-EAFA49CAAB7B',
'9342695D-5FB4-41FD-B895-12F69E367B27'
);

select * from TOURS;
select * from USERS;
select * from ORDERS;

delete from DISCOUNTS;

insert into DISCOUNTS values (NEWID(),'1A061F8B-0C24-4E83-9816-889F8A31FB72',0.8);

insert into FEEDBACKS values (NEWID(), 'D4EEE7FC-B85E-484E-ABB9-F1FA0E973003', 'B400DF3A-2E7B-4B89-AF15-ECAFA904912D',4);
insert into FEEDBACKS values (NEWID(), '6D9E8070-4E76-4600-BA09-D3586746DF47', 'B400DF3A-2E7B-4B89-AF15-ECAFA904912D',3);

insert into ORDERS values(NEWID(), 'E688E17E-798B-4F18-B988-C8208807CC5F', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());

insert into ORDERS values(NEWID(), '6DE25268-4EBF-4513-84F4-AADF357CDF57', 'D4EEE7FC-B85E-484E-ABB9-F1FA0E973003', 3, 2, GETDATE(), RAND());

select * from ORDERS;