
USE bank_churn;
DESCRIBE Customers;
SELECT
    customer_id,
    balance,
    CASE
        WHEN balance < 50000 THEN 'Low'
        WHEN balance BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS Portfolio_Segment
FROM Customers;

SELECT
    CASE
        WHEN balance < 50000 THEN 'Low'
        WHEN balance BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS Portfolio_Segment,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Portfolio_Segment;

SELECT count(*) AS Total_Customers
From Customers;

SELECT
    SUM(Total_Customers) AS Verified_Total
FROM (
    SELECT
        CASE
            WHEN balance < 50000 THEN 'Low'
            WHEN balance BETWEEN 50000 AND 100000 THEN 'Medium'
            ELSE 'High'
        END AS Portfolio_Segment,
        COUNT(*) AS Total_Customers
    FROM Customers
    GROUP BY Portfolio_Segment
) AS Segments;