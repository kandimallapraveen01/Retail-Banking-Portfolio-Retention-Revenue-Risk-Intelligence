USE bank_churn;
DESCRIBE Customers;

SELECT
    products_number,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY products_number
ORDER BY products_number;

SELECT
    products_number,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Exited_Customers,
    ROUND((SUM(churn) * 100.0) / COUNT(*), 2) AS Exit_Rate_Percentage
FROM Customers
GROUP BY products_number
ORDER BY products_number;

CREATE VIEW Single_Product_Customers AS
SELECT
    customer_id,
    geography,
    gender,
    age,
    balance,
    products_number,
    active_member,
    churn
FROM Customers
WHERE products_number = 1;

SELECT *
FROM Single_Product_Customers
LIMIT 10;