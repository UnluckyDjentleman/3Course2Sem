create or alter procedure GetTheMostExpensiveTour
as
begin
set nocount on;
begin try
	declare @EXPTOUR money=(select MAX(costForOnePerson) from TOURS);

	select * from DETAILED_VIEW_TOUR where costForOnePerson=@EXPTOUR;
	return 1;
end try
begin catch
	declare @ERROR_MESSAGE nvarchar(max), @ERROR_SEVERITY int, @ERROR_STATE int;
        select @ERROR_MESSAGE = ERROR_MESSAGE(), 
			   @ERROR_SEVERITY = ERROR_SEVERITY(),
			   @ERROR_STATE = ERROR_STATE();
		raiserror (@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE);
        return -1;
end catch
end;

declare @RES money;
exec @RES=GetTheMostExpensiveTour
print 'The most expensive tour:'+cast(@RES as nvarchar)

create or alter procedure AddNewTour
@TOUR_NAME nvarchar(100),
@CITY_NAME nvarchar(30),
@COUNTRY_NAME nvarchar(30),
@CATEGORY_NAME nvarchar(100),
@DESCR nvarchar(1000),
@DUR int,
@COSTFORONE money,
@TRNAME nvarchar(20),
@HNAME nvarchar(40)
as
begin
set nocount on;
begin try
	DECLARE @TOUR_ID uniqueidentifier=NEWID(),
			@CITY_ID char(3)=(select cityId from CITIES where cityName=@CITY_NAME),
			@COUNTRY_ID char(2)=(select countryId from COUNTRIES where countryName=@COUNTRY_NAME),
			@CATEGORY_ID uniqueidentifier=(select categoryId from CATEGORIES where categoryName=@CATEGORY_NAME),
			@TRID uniqueidentifier=(select transportId from TRANSPORTS where transportName=@TRNAME),
			@HID uniqueidentifier=(select hotelId from HOTELS where hotelName=@HNAME);
			print 'CITY_ID: '+cast(@CITY_ID as nvarchar)
			begin tran
				insert into TOURS(tourId,tourName,countryId,cityId,categoryId,description,duration,costForOnePerson,average_mark,transportId,hotelId) values (@TOUR_ID,@TOUR_NAME,@COUNTRY_ID,@CITY_ID,@CATEGORY_ID,@DESCR,@DUR,@COSTFORONE,0,@TRID,@HID);
			commit;

			select * from TOURS where tourId=@TOUR_ID;
			print 'Added new tour!';
			return 1;
end try
begin catch
declare @ERROR_MESSAGE nvarchar(max), @ERROR_SEVERITY int, @ERROR_STATE int;
        select @ERROR_MESSAGE = ERROR_MESSAGE(), 
			   @ERROR_SEVERITY = ERROR_SEVERITY(),
			   @ERROR_STATE = ERROR_STATE();
		rollback;
		raiserror (@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE);
        return -1;
end catch
end;

declare @RESULT int;
exec @RESULT=AddNewTour @TOUR_NAME=N'In the vampire''s lair', @CITY_NAME=N'Bucharest', @COUNTRY_NAME=N'Romania', @CATEGORY_NAME=N'Sightseeing',@DESCR=N'Visit the old caves and Vlad Drakula''s palace.',@DUR=15,@COSTFORONE=666,@TRNAME=N'Bus',@HNAME=N'Crypto'
print 'Returned: '+cast(@RESULT as nvarchar)

create or alter procedure SetTheFeedBack
@USERNAME nvarchar(50),
@USERSURNAME nvarchar(50),
@TOURNAME nvarchar(100),
@MARK float
as
begin
set nocount on;
begin try
	declare @FEEDBACK_ID uniqueidentifier=NEWID(),
			@USER_ID uniqueidentifier=(select userId from USERS where name=@USERNAME and surname=@USERSURNAME),
			@TOUR_ID uniqueidentifier=(select tourId from TOURS where tourName=@TOURNAME)
			begin tran
				insert into FEEDBACKS values (@FEEDBACK_ID,@USER_ID,@TOUR_ID,@MARK);
			commit;
	select * from TOURS where tourId=@TOUR_ID;
	print (cast(@USERNAME as nvarchar))+' '+(cast(@USERSURNAME as nvarchar))+' set the mark'+cast(@MARK as nvarchar)+'to the tour '+cast(@TOURNAME as nvarchar);
end try
begin catch
end catch
end;

declare @RESULTUS int;
exec SetTheFeedBack @USERNAME='Mikhail', @USERSURNAME='Vergeyczyk', @TOURNAME=N'In the vampire''s lair', @MARK=5
print 'Returned: '+cast(@RESULTUS as varchar)