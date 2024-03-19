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
        DateStart BETWEEN '2020-01-01' AND '2024-01-01'
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
SELECT 
    USERS.userId,
    COUNT(orders.userId) AS visits
FROM 
    USERS
INNER JOIN 
    orders
    ON users.userId=orders.orderId
inner join tours on tours.tourId=orders.tourId
inner join countries on countries.countryId=tours.countryId
GROUP BY 
    USERS.userId,
	COUNTRIES.countryId
ORDER BY 
    userId,
    visits;

--5
select 
TOURS.tourName,
MAX(FEEDBACKS.mark) as highests_marks_of_tour
from
TOURS join FEEDBACKS on tours.tourId=feedbacks.tourId group by tours.tourName

