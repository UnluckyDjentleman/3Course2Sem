insert into ORDERS values(NEWID(), 'B400DF3A-2E7B-4B89-AF15-ECAFA904912D', 'BF33761B-1B63-44B7-8E75-0FF65FDC224E', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), 'B400DF3A-2E7B-4B89-AF15-ECAFA904912D', 'DDD6DECD-9CC1-4046-9653-53A996D687D2', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '23960F99-62AE-48D7-871F-3AADABD468DB', '8D11AF6D-877B-4B83-9435-9167D06C2904', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '23960F99-62AE-48D7-871F-3AADABD468DB', '359F924C-3EFB-4DDC-A1F9-9704DAA4A96E', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '1A061F8B-0C24-4E83-9816-889F8A31FB72', 'D25E0C69-6431-46F3-81BD-5D47960CA497', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '1A061F8B-0C24-4E83-9816-889F8A31FB72', '6D9E8070-4E76-4600-BA09-D3586746DF47', 3, 2, GETDATE(), RAND());

select * from users;
select * from orders;
select * from tours;
--1.
select year(DateStart) as year, 
case when Month(DateStart) BETWEEN 1 AND 6 THEN 'H1'
else 'H2'
end as half_year,
datepart(quarter, DateStart) as quarter,
month(DateStart) as month,
sum(cost) as profit
from ORDERS group by
grouping sets(
		(YEAR(DateStart), CASE WHEN MONTH(DateStart) BETWEEN 1 AND 6 THEN 'H1' ELSE 'H2' END, DATEPART(QUARTER, DateStart), MONTH(DateStart)),
        (YEAR(DateStart), CASE WHEN MONTH(DateStart) BETWEEN 1 AND 6 THEN 'H1' ELSE 'H2' END, DATEPART(QUARTER, DateStart)),
        (YEAR(DateStart), CASE WHEN MONTH(DateStart) BETWEEN 1 AND 6 THEN 'H1' ELSE 'H2' END),
        (YEAR(DateStart))
)

--2
select service_count as volume,
(convert(decimal(10,2),service_count)/total_count)*100 as total_per,
(convert(decimal(10,2),service_count)/max_count)*100 as max_per
from 
(
select count(*) as service_count from orders join tours on orders.tourId=tours.tourId where DateStart between '2023-01-01' and '2023-09-01' and tours.tourName='Wildlife'
) as service,
(
select count(*) as total_count from orders
) as total,
(
select max(service_count) as max_count from (
		select count(*) as service_count from orders join tours on orders.tourId=tours.tourId where DateStart between '2023-01-01' and '2023-09-01' group by tours.tourId
	) as serv_counts
) as max_service;

--3
SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY DateStart) AS row_num,
        orders.*
    FROM 
        orders
    WHERE 
        DateStart BETWEEN '2022-01-01' AND '2024-01-01'
) AS numbered_payments
WHERE row_num BETWEEN 1 AND 20;

SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY orderId ORDER BY DateStart) AS row_num,
        orders.*
    FROM 
        orders
    WHERE 
        DateStart BETWEEN '2023-01-01' AND '2023-05-01'
) AS partitioned_payments
WHERE row_num = 1;

--4
select u.userId, top_6_countries.countryId, count(o.userId) as count_of_visits 
from users u 
join 
	orders o 
	on u.userId=o.userId 
join 
	tours t 
	on o.tourId=t.tourId 
join (
	select top 6 countries.countryId, 
	count(countries.countryId) as count_of_visits 
	from orders 
	join 
		tours 
	on orders.tourId=tours.tourId 
	join 
		countries on tours.countryId=countries.countryId 
	group by countries.countryId
) 
	as top_6_countries 
	on t.countryId=top_6_countries.countryId 
group by 
	u.userId, top_6_countries.countryId
order by
	u.userId, count_of_visits;
--5
select 
c.categoryName,
MAX(t.tourName) as most_popular_tour_category
from
CATEGORIES c 
join tours t on
	t.categoryId=c.categoryId
join orders o on
	o.tourId=t.tourId
group by
	c.categoryName;
