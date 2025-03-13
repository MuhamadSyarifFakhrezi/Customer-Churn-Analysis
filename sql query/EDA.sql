--The number of customers
SELECT COUNT(*) FROM telecom_customer_churn;

--The number of customers by customer status
SELECT 
	"Customer Status", 
	COUNT(*) AS "Customer Count", 
	ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM telecom_customer_churn
GROUP BY 1;

--Lost revenue due to churned customers
SELECT
	"Customer Status",
	SUM("Total Revenue") AS "Total Revenue",
	ROUND(100.0 * SUM("Total Revenue") / SUM(SUM("Total Revenue")) OVER(), 2) AS "Percentage of Total Revenue"
FROM telecom_customer_churn
GROUP BY 1;

--Churn rate by tenure
SELECT
	CASE
		WHEN "Tenure in Months" <= 6 THEN "0-6 Months"
		WHEN "Tenure in Months" <= 12 THEN "6 Months-1 Year"
		WHEN "Tenure in Months" <= 24 THEN "1-2 Years"
		ELSE "More Than 2 Years"
	END AS Tenure,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;

--Churn rate by offer
SELECT
	Offer,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;

--Churn rate by contract
SELECT
	Contract,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;

--Churn rate by city
SELECT
	City,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
HAVING COUNT(*) >= 30
ORDER BY 4 DESC
LIMIT 5;

--Churn rate by age
SELECT
	CASE
		WHEN Age <= 25 THEN "18-25 Years Old"
		WHEN Age > 25 AND Age <= 45 THEN "26-45 Years Old"
		WHEN Age > 45 AND Age <= 65 THEN "46-65 Years Old"
		ELSE "66-80 Years Old"
	END AS "Age Group",
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;

--The most reasons for churn
SELECT
	"Churn Reason",
	"Churn Category",
	COUNT(*) AS "Number of Customers",
	SUM("Total Revenue") AS "Total Revenue",
	ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS "Percentage of Churn"
FROM telecom_customer_churn
WHERE "Customer Status" == "Churned"
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;