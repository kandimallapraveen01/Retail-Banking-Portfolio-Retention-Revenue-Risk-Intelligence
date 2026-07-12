USE bank_churn;
DESCRIBE Customers;

WITH Risk_Tiering AS
(
    SELECT
        customer_id,
        credit_score,
        tenure,

        CASE
            WHEN credit_score < 500 OR tenure <= 2 THEN 'High Risk'
            WHEN credit_score BETWEEN 500 AND 700 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Tier

    FROM Customers
)

SELECT *
FROM Risk_Tiering;


WITH Risk_Tiering AS
(
    SELECT
        customer_id,
        credit_score,
        tenure,

        CASE
            WHEN credit_score < 500 OR tenure <= 2 THEN 100
            WHEN credit_score BETWEEN 500 AND 700 THEN 60
            ELSE 20
        END AS Risk_Weight

    FROM Customers
)

SELECT *
FROM Risk_Tiering;



WITH Risk_Tiering AS
(
    SELECT
        customer_id,
        balance,
        active_member,
        credit_score,
        tenure,

        CASE
            WHEN credit_score < 500 OR tenure <= 2 THEN 100
            WHEN credit_score BETWEEN 500 AND 700 THEN 60
            ELSE 20
        END AS Risk_Weight

    FROM Customers
)

SELECT
    customer_id,
    balance,
    active_member,
    Risk_Weight
FROM Risk_Tiering
WHERE balance > 100000
  AND active_member = 0
ORDER BY Risk_Weight DESC,
         balance DESC;