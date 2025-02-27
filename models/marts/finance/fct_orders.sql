WITH orders AS (
    SELECT *
    FROM {{ ref('stg_jaffle_shop__orders') }}
), 

payments AS (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
),

order_payments AS (
    SELECT 
        order_id
        ,SUM(CASE WHEN payment_status = 'success' THEN payment_amount ELSE 0 END) AS payment_amount
    FROM payments 
    GROUP BY 1
),

final AS (
    SELECT 
        orders.order_id
        ,orders.customer_id
        ,orders.order_date
        ,COALESCE(order_payments.payment_amount, 0) AS payment_amount
    FROM orders 
    LEFT JOIN order_payments USING (order_id)
)

SELECT * FROM final 