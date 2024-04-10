SELECT
    userid,
    TO_CHAR(ADD_MONTHS(SYSDATE, 12), 'YYYY-MM') AS month,
    ROUND(sal * (1 + tour_cost_percent), 2) AS predicted_salary
FROM (
    select e.userId as userid, e.salary as sal, (sum(sum(o.cost)) over(partition by e.userId)/sum(sum(o.cost)) over()) as tour_cost_percent from orders o join employees e on e.tourId=o.tourId group by e.userId,e.salary
)
Model
    DIMENSION BY (userid)
    MEASURES (sal, tour_cost_percent)
    RULES (
        sal[FOR userid from 71 to 77 increment 1]
            = sal[CV()] * (1 + tour_cost_percent[CV()])
    )
ORDER BY userid, month;

select e.userId, sum(o.cost) from orders o join employees e on e.tourId=o.tourId group by e.userId;

SELECT start_quarter, end_quarter
FROM (
    SELECT TO_CHAR(DateStart, 'YYYY-Q') AS quarter, 
           SUM(cost) AS total_income
    FROM ORDERS
    GROUP BY TO_CHAR(DateStart, 'YYYY-Q')
)
MATCH_RECOGNIZE (
    ORDER BY quarter
    MEASURES FIRST(quarter) AS start_quarter,
             LAST(quarter) AS end_quarter
    ONE ROW PER MATCH
    PATTERN (GROWTH FALL GROWTH)
    DEFINE 
        GROWTH AS total_income > PREV(total_income),
        FALL AS total_income < PREV(total_income)
);