USE bank_churn;
DESCRIBE Customers;
SELECT
    customer_id,
    geography,
    balance,
    estimated_salary,
    AVG(estimated_salary) OVER(PARTITION BY geography) AS Avg_Salary_By_Geography
FROM Customers;

SELECT
    customer_id,
    geography,
    balance,
    AVG(balance) OVER() AS Portfolio_Average,
    balance - AVG(balance) OVER() AS Difference_From_Average
FROM Customers;

SELECT
    customer_id,
    balance,
    products_number,
    active_member,
    churn,
    CASE
        WHEN balance < 50000
             AND products_number = 1
             AND active_member = 0
             AND churn = 0
        THEN 'High Silent Attrition Risk'

        WHEN balance < 80000
             AND churn = 0
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS Silent_Attrition_Risk
FROM Customers;