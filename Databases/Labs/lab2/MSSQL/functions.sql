create or alter function GetCountOfCountries()
returns int
as
begin
declare @COUNTR int=(select COUNT(*) from COUNTRIES);
return @COUNTR;
end;

select dbo.GetCountOfCountries() as CountriesCounter;

create or alter function GetCitiesByCountry(
@COUNTRY_ID char(2)
) returns table
as
	return (select cityId, cityName from CITIES where countryId=@COUNTRY_ID);

select * from GetCitiesByCountry(N'JP');

create or alter function GetToursByTransport(
	@TRNAME nvarchar(20)
) 
returns table
as
	return (select * from TOURS where transportId=(select transportId from TRANSPORTS where transportName=@TRNAME));

 select * from GetToursByTransport(N'Plane');
