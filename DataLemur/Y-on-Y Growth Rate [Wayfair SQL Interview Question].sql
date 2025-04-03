select *, round((curr_year_spend-prev_year_spend)*100/prev_year_spend,2) as yoy_rate from 
(
SELECT *, lag(curr_year_spend) over (partition by product_id order by year) as prev_year_spend FROM
(
SELECT EXTRACT(year from transaction_date) as year, product_id, sum(spend) as curr_year_spend
FROM user_transactions group by product_id, year
)x
)y
