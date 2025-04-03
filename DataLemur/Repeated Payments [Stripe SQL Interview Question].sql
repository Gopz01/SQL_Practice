-- same cc, same amount, saem merchant

select count(*) as payment_count from
(
SELECT 
  *, lead(transaction_timestamp) over (partition by merchant_id, credit_card_id order by transaction_timestamp) as ld ,
  lead(amount) over (partition by merchant_id, credit_card_id order by transaction_timestamp) as ld1 
FROM transactions
)x
where extract(minute from ld-transaction_timestamp) < 10 and amount = ld1
