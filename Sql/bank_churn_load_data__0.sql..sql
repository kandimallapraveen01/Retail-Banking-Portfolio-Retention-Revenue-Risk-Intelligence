CREATE DATABASE bank_churn;
USE bank_churn;

CREATE TABLE Customers (
    customer_id BIGINT PRIMARY KEY,
    credit_score INT,
    geography VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance DECIMAL(15,2),
    products_number INT,
    credit_card TINYINT,
    active_member TINYINT,
    estimated_salary DECIMAL(15,2),
    churn TINYINT
);
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'D:/pravven/customer.csv/Churn.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
USE bank_churn;
SHOW TABLES;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) AS total_customers
FROM Customers;
SELECT * FROM Customers LIMIT 5;
TRUNCATE TABLE Customers;
LOAD DATA LOCAL INFILE 'D:/praveen/Churn.csv.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,
credit_score,
geography,
gender,
age,
tenure,
balance,
products_number,
credit_card,
active_member,
estimated_salary,
churn);
USE bank_churn;

LOAD DATA LOCAL INFILE 'D:/churn.csv.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,
credit_score,
geography,
gender,
age,
tenure,
balance,
products_number,
credit_card,
active_member,
estimated_salary,
churn);


describe customers;

SELECT DISTINCT geography
FROM Customers;

select geography , count(*) AS total
FROM customers
Group bY geography
order by total DESC;

select *
from customers
where geography is null
	or trim(geography) = '';
    
SELECT
MIN(estimated_salary) AS min_salary,
MAX(estimated_salary) AS max_salary,
AVG(estimated_salary) AS avg_salary
FROM Customers;

SELECT *
FROM Customers
WHERE estimated_salary < 0;

/* Check NULL values */

SELECT *
FROM Customers
WHERE estimated_salary IS NULL;

/* Data Quality issue's */

SELECT *
FROM Customers
ORDER BY estimated_salary DESC
LIMIT 10;

SELECT
SUM(CASE WHEN geography IS NULL OR TRIM(geography) = '' THEN 1 ELSE 0 END) AS geography_missing,
SUM(CASE WHEN estimated_salary IS NULL THEN 1 ELSE 0 END) AS salary_missing,
SUM(CASE WHEN estimated_salary < 0 THEN 1 ELSE 0 END) AS negative_salary
FROM Customers;