USE bank_churn;

DESCRIBE Customers;

TRUNCATE TABLE Customers;

SELECT COUNT(*) FROM Customers;

SELECT *
FROM Customers
WHERE customer_id IS NULL;

SELECT customer_id, COUNT(*)
FROM Customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


SELECT MIN(balance), MAX(balance)
FROM Customers;
