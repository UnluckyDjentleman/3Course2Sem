select * from COUNTRIES;
select * from CITIES where countryId like '%N%';

create index COUNTRIES_INDX on COUNTRIES(countryName);
create index CITIES_IDX on CITIES(cityName, countryId);