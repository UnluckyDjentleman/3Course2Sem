create or replace function GetCountOfCountries
return number
is
countr number(6);
begin
    select COUNT(*) into countr from COUNTRIES;
    return COUNTR;
end;

select GetCountOfCountries() as CountriesCounter;

create or replace function GetCitiesByCountry(
COUNTRY_ID char
) return number
is
    emp_c sys_refcursor;
    v_c_id cities.cityId%type;
    v_c_name cities.cityName%type;
begin
    open emp_c for 
    select cityId, cityName from Cities where countryId=COUNTRY_ID;
    LOOP
    FETCH emp_c
    INTO  v_c_id, v_c_name;
    EXIT WHEN emp_c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_c_id || ' - ' || v_c_name);
    END LOOP;
    CLOSE emp_c;
    return 1;
end;

select GetCitiesByCountry('JP');

create or replace function GetToursByTransport(
	TRNAME varchar
) return number
is
    emp_c sys_refcursor;
    v_t_name tours.tourName%type;
    v_tr_id transports.transportId%type;
begin
    select transportId into v_tr_id from transports where transportName=TRNAME;
    open emp_c for 
    select tourName from Tours where transportId=v_tr_id;
    LOOP
    FETCH emp_c
    INTO  v_t_name;
    EXIT WHEN emp_c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_t_name);
    END LOOP;
    CLOSE emp_c;
    return 1;
end;
 select GetToursByTransport('Plane');