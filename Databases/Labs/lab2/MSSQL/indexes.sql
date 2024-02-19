select * from COUNTRIES;
select * from CITIES where countryId like '%N%'

create index COUNTRIES_INDX on COUNTRIES(countryId);
create index CITIES_IDX on CITIES(cityId, countryId);
create index TOURS_IDX on TOURS(tourId) include (tourName);

