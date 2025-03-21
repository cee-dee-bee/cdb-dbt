WITH payments AS (
    SELECT * FROM {{ ref('stg_stripe__payments') }}
)

SELECT
    order_id,
    sum(payment_amount) as total_amount
FROM {{ ref('stg_stripe__payments') }}
GROUP BY 1
HAVING total_amount < 0