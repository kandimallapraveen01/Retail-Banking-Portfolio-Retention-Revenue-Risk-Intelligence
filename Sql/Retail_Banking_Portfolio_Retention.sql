USE bank_churn;
DESCRIBE Customers;
SHOW FULL TABLES;

/*----------------------
Portfolio Segmentation
-----------------------*/
CREATE VIEW portfolio_segmentation AS
SELECT
    customer_id,
    CASE
        WHEN balance < 50000 THEN 'Low'
        WHEN balance <= 100000 THEN 'Medium'
        ELSE 'High'
    END AS Portfolio_Segment
FROM Customers;

SELECT *
FROM portfolio_segmentation
LIMIT 10;

/*-- ==========================================
-- 2. Risk Tiering
-- ==========================================*/
CREATE VIEW risk_tiering AS
SELECT
    customer_id,
    credit_score,
    tenure,
    CASE
        WHEN credit_score >= 750 AND tenure >= 7 THEN 90
        WHEN credit_score >= 650 AND tenure >= 5 THEN 70
        WHEN credit_score >= 550 THEN 50
        ELSE 30
    END AS Risk_Score
FROM Customers;

SELECT *
FROM risk_tiering
LIMIT 10;

/*-- ==========================================
-- 3. Activity Trend
-- ==========================================*/
CREATE VIEW activity_trend AS
SELECT
    customer_id,
    geography,
    estimated_salary,
    AVG(estimated_salary) OVER (PARTITION BY geography) AS Avg_Salary_By_Geography
FROM Customers;

SELECT *
FROM activity_trend
LIMIT 10;

/*-- ==========================================
-- 4. Silent Attrition Risk
-- ==========================================*/
CREATE VIEW silent_attrition_risk AS
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
        THEN 'Medium Silent Attrition Risk'

        ELSE 'Low Silent Attrition Risk'
    END AS Risk_Category
FROM Customers;

SELECT *
FROM silent_attrition_risk
LIMIT 10;

/*-- ==========================================
-- 5. Master Analytics
-- ==========================================*/
CREATE VIEW master_analytics AS
SELECT
    c.customer_id,
    c.geography,
    c.gender,
    c.age,
    c.balance,
    c.products_number,
    c.active_member,
    c.churn,
    ps.Portfolio_Segment,
    rt.Risk_Score,
    at.Avg_Salary_By_Geography,
    sar.Risk_Category
FROM Customers c
LEFT JOIN portfolio_segmentation ps
    ON c.customer_id = ps.customer_id
LEFT JOIN risk_tiering rt
    ON c.customer_id = rt.customer_id
LEFT JOIN activity_trend at
    ON c.customer_id = at.customer_id
LEFT JOIN silent_attrition_risk sar
    ON c.customer_id = sar.customer_id;
SELECT *
FROM master_analytics
LIMIT 10;

/*-- ==========================================
-- 6. Final Data Audit
-- ==========================================*/
SELECT COUNT(*) AS Total_Customers
FROM Customers;
SELECT
    SUM(balance) AS Total_Balance
FROM Customers;

SELECT
    geography,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY geography;
SELECT
    churn,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY churn;
SELECT
    Portfolio_Segment,
    COUNT(*) AS Total_Customers
FROM portfolio_segmentation
GROUP BY Portfolio_Segment;
SELECT
    Risk_Category,
    COUNT(*) AS Total_Customers
FROM silent_attrition_risk
GROUP BY Risk_Category;