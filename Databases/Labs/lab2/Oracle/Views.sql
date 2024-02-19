create or replace view DETAILED_VIEW_TOUR
as
	select t.tourId,
		   t.tourName, 
		   co.countryId,
		   ci.cityId,
		   cat.categoryName,
		   t.description,
		   t.duration,
		   t.costForOnePerson,
		   t.average_mark,
		   tr.transportName,
		   h.hotelName
	from TOURS t 
		join COUNTRIES co on t.countryId=co.countryId
		join CITIES ci on t.cityId=ci.cityId
		join CATEGORIES cat on t.categoryId=cat.categoryId
		join TRANSPORTS tr on t.transportId=tr.transportId
		join HOTELS h on t.hotelId=h.hotelId;

select * from DETAILED_VIEW_TOUR;

create or replace view DETAILED_VIEW_ORDER
as
	select o.orderId, u.name, u.surname, u.email,
		   t.tourname, o.adultsCount, o.childrenCount, o.DateStart, o.cost
		   from ORDERS o join USERS u on o.userId=u.userId join TOURS t on o.tourId =t.tourId;

select * from DETAILED_VIEW_ORDER;

create or replace view CITY_COUNTRY_HOTEL
as
	select ci.cityName, co.countryName, h.hotelName from CITIES ci
		join COUNTRIES co on ci.countryId=co.countryId join HOTELS h on ci.cityId=h.cityId;

select * from CITY_COUNTRY_HOTEL;
