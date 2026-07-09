USE bank_churn;
DESCRIBE Customers;

SELECT
    Geography,
    Churn,
    COUNT(*) AS Total_Customers,
    SUM(Balance) AS Total_Balance
FROM Customers
GROUP BY Geography, Churn
ORDER BY Geography, Churn;