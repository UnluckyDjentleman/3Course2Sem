create or replace procedure GetTheMostExpensiveTour
is
exptour number;
begin
    select max(costForOnePerson) into exptour from TOURS;
	select * from DETAILED_VIEW_TOUR where costForOnePerson=cast(exptour as number);
end;

create or replace procedure AddNewTour(
TOUR_NAME varchar,
CITY_ID char,
COUNTRY_ID char,
CATEGORY_NAME varchar2,
DESCR varchar,
DUR int,
COSTFORONE number,
TRNAME varchar,
HNAME varchar)
is
begin
    insert into Tours(tourName,cityId,countryId,categoryId,description,duration,costForOnePerson, average_mark, transportId, hotelId) values(
            tour_name,
            city_id,
            country_id,
            cast((select categoryId from CATEGORIES where categoryName=category_name) as number),
            descr,
            dur,
            costforone,
            0,
            cast((select transportId from TRANSPORTS where transportName=trname) as number),
            cast((select hotelId from HOTELS where hotelName=hname) as number)
    );
end;

select * from TOURS;

begin
    AddNewTour('In the vampire''s lair', 'BUC','RM','Sightseeing','Visit the old caves and Vlad Drakula''s palace.',15,666,'Bus','Crypto');
end;