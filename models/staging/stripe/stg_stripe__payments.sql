  SELECT
    id AS paymt_id
    ,orderid AS order_id
    ,paymentmethod AS payment_method
    ,status AS payment_status
    -- amount is stored in cents, convert to dollars
    ,amount/100 AS payment_amount
    ,created AS payment_created_date
  FROM `cdb-learns-dbt.stripe.payment`