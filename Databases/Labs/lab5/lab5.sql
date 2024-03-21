insert into ORDERS values(NEWID(), '014B5452-6C8B-4EE9-8426-4ACD5404C881', '5E8A194B-22A5-4278-9037-8124985BD45B', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '014B5452-6C8B-4EE9-8426-4ACD5404C881', '4C518FA8-3247-427B-8AEC-6156B7DBA27F', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '41004A10-7499-4058-A59B-7796C538FA5A', 'D25E0C69-6431-46F3-81BD-5D47960CA497', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '41004A10-7499-4058-A59B-7796C538FA5A', '8D11AF6D-877B-4B83-9435-9167D06C2904', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), 'E688E17E-798B-4F18-B988-C8208807CC5F', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '41004A10-7499-4058-A59B-7796C538FA5A', 'D4EEE7FC-B85E-484E-ABB9-F1FA0E973003', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '23960F99-62AE-48D7-871F-3AADABD468DB', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), 'D3573027-4AB4-404E-BDC5-5C63D20E61A5', '1E87A378-19D5-4657-A239-A86BF80F8F6C', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), 'D3573027-4AB4-404E-BDC5-5C63D20E61A5', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '6DE25268-4EBF-4513-84F4-AADF357CDF57', 'D4EEE7FC-B85E-484E-ABB9-F1FA0E973003', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '9182DD4F-FAE8-498B-906C-BF92EE8E0834', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '9182DD4F-FAE8-498B-906C-BF92EE8E0834', '6D9E8070-4E76-4600-BA09-D3586746DF47', 3, 2, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '41004A10-7499-4058-A59B-7796C538FA5A', 'A321FB33-036F-4606-B141-4911CB78CD53', 2, 1, GETDATE(), RAND());
insert into ORDERS values(NEWID(), '9182DD4F-FAE8-498B-906C-BF92EE8E0834', '359F924C-3EFB-4DDC-A1F9-9704DAA4A96E', 3, 2, GETDATE(), RAND());

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
TOURS.tourName,
MAX(FEEDBACKS.mark) as highests_marks_of_tour
from
TOURS join FEEDBACKS on tours.tourId=feedbacks.tourId group by tours.tourName

