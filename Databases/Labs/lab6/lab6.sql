----1
select to_char(DateStart, 'YYYY') as year, 
case 
when to_char(DateStart, 'MM') IN ('01','02','03','04','05','06') THEN 'H1'
else 'H2'
end as half_year,
to_char(DateStart,'Q') as quarter,
to_char(DateStart, 'MM') as month,
sum(cost) as profit
from ORDERS group by rollup(year, half_year, quarter, month);


select * from orders;

-----2
select service_count as volume,
service_count/total_count*100 as total_per,
service_count/max_count*100 as max_per
from 
(
select count(*) as service_count from orders join tours on orders.tourId=tours.tourId where DateStart between to_date('01-01-22') and to_date('01-09-24') and tours.tourName='Sakura Flowers'
),
(
select count(*) as total_count from orders
),
(
select max(service_count) as max_count from (select count(*) as service_count from orders join tours on orders.tourId=tours.tourId where DateStart between to_date('01-01-22') and to_date('01-09-24') group by tours.tourId)
);

----3
SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY DateStart) AS row_num,
        orders.*
    FROM 
        orders
    WHERE 
        DateStart between to_date('01-01-22') and to_date('01-09-24')
)
WHERE row_num BETWEEN 1 AND 10;

SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY userId order by DateStart) AS row_num,
        orders.*
    FROM 
        orders
    WHERE 
        DateStart between to_date('01-01-22') and to_date('01-09-24')
)
WHERE row_num=1;
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
	select countries.countryId, 
	count(countries.countryId) as count_of_visits 
	from orders
	join 
		tours 
	on orders.tourId=tours.tourId 
	join 
		countries on tours.countryId=countries.countryId where rownum<=7
	group by countries.countryId) top_6_countries
    on t.countryId=top_6_countries.countryId 
    group by u.userId, top_6_countries.countryId
    order by u.userId, count_of_visits;
    
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