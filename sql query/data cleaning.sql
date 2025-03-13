--Check for Duplicates
SELECT "Customer ID", COUNT(*) AS "Count"
FROM telecom_customer_churn
GROUP BY 1
HAVING COUNT(*) > 1;

--Check for NULL Values
PRAGMA table_info(telecom_customer_churn);

SELECT
	COUNT(*),
	SUM(CASE WHEN "Customer ID" IS NULL THEN 1 ELSE 0 END) AS "Customer ID Nulls",
	SUM(CASE WHEN "Gender" IS NULL THEN 1 ELSE 0 END) AS "Gender Nulls",
	SUM(CASE WHEN "Age" IS NULL THEN 1 ELSE 0 END) AS "Age Nulls",
	SUM(CASE WHEN "Married" IS NULL THEN 1 ELSE 0 END) AS "Married Nulls",
	SUM(CASE WHEN "Number of Dependents" IS NULL THEN 1 ELSE 0 END) AS "Number of Dependents Nulls",
	SUM(CASE WHEN "City" IS NULL THEN 1 ELSE 0 END) AS "City Nulls",
	SUM(CASE WHEN "Zip Code" IS NULL THEN 1 ELSE 0 END) AS "Zip Code Nulls",
	SUM(CASE WHEN "Latitude" IS NULL THEN 1 ELSE 0 END) AS "Latitude Nulls",
	SUM(CASE WHEN "Longitude" IS NULL THEN 1 ELSE 0 END) AS "Longitude Nulls",
	SUM(CASE WHEN "Number of Referrals" IS NULL THEN 1 ELSE 0 END) AS "Number of Referrals Nulls",
	SUM(CASE WHEN "Tenure in Months" IS NULL THEN 1 ELSE 0 END) AS "Tenure in Months Nulls",
	SUM(CASE WHEN "Offer" IS NULL THEN 1 ELSE 0 END) AS "Offer Nulls",
	SUM(CASE WHEN "Phone Service" IS NULL THEN 1 ELSE 0 END) AS "Phone Service Nulls",
	SUM(CASE WHEN "Avg Monthly Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS "Avg Monthly Long Distance Charges Nulls",
	SUM(CASE WHEN "Multiple Lines" IS NULL THEN 1 ELSE 0 END) AS "Multiple Lines Nulls",
	SUM(CASE WHEN "Internet Service" IS NULL THEN 1 ELSE 0 END) AS "Internet Service Nulls",
	SUM(CASE WHEN "Internet Type" IS NULL THEN 1 ELSE 0 END) AS "Internet Type Nulls",
	SUM(CASE WHEN "Avg Monthly GB Download" IS NULL THEN 1 ELSE 0 END) AS "Avg Monthly GB Download Nulls",
	SUM(CASE WHEN "Online Security" IS NULL THEN 1 ELSE 0 END) AS "Online Security Nulls",
	SUM(CASE WHEN "Online Backup" IS NULL THEN 1 ELSE 0 END) AS "Online Backup Nulls",
	SUM(CASE WHEN "Device Protection Plan" IS NULL THEN 1 ELSE 0 END) AS "Device Protection Plan Nulls",
	SUM(CASE WHEN "Premium Tech Support" IS NULL THEN 1 ELSE 0 END) AS "Premium Tech Support Nulls",
	SUM(CASE WHEN "Streaming TV" IS NULL THEN 1 ELSE 0 END) AS "Streaming TV Nulls",
	SUM(CASE WHEN "Streaming Movies" IS NULL THEN 1 ELSE 0 END) AS "Streaming Movies Nulls",
	SUM(CASE WHEN "Streaming Music" IS NULL THEN 1 ELSE 0 END) AS "Streaming Music Nulls",
	SUM(CASE WHEN "Unlimited Data" IS NULL THEN 1 ELSE 0 END) AS "Unlimited Data Nulls",
	SUM(CASE WHEN "Contract" IS NULL THEN 1 ELSE 0 END) AS "Contract Nulls",
	SUM(CASE WHEN "Paperless Billing" IS NULL THEN 1 ELSE 0 END) AS "Paperless Billing Nulls",
	SUM(CASE WHEN "Payment Method" IS NULL THEN 1 ELSE 0 END) AS "Payment Method Nulls",
	SUM(CASE WHEN "Monthly Charge" IS NULL THEN 1 ELSE 0 END) AS "Monthly Charge Nulls",
	SUM(CASE WHEN "Total Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Charges Nulls",
	SUM(CASE WHEN "Total Refunds" IS NULL THEN 1 ELSE 0 END) AS "Total Refunds Nulls",
	SUM(CASE WHEN "Total Extra Data Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Extra Data Charges Nulls",
	SUM(CASE WHEN "Total Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Long Distance Charges Nulls",
	SUM(CASE WHEN "Total Revenue" IS NULL THEN 1 ELSE 0 END) AS "Total Revenue Nulls",
	SUM(CASE WHEN "Customer Status" IS NULL THEN 1 ELSE 0 END) AS "Customer Status Nulls",
	SUM(CASE WHEN "Churn Category" IS NULL THEN 1 ELSE 0 END) AS "Churn Category Nulls",
	SUM(CASE WHEN "Churn Reason" IS NULL THEN 1 ELSE 0 END) AS "Churn Reason Nulls"
FROM telecom_customer_churn;

--Check NULL Values in Column Phone Service
SELECT DISTINCT "Avg Monthly Long Distance Charges", "Multiple Lines"
FROM telecom_customer_churn
WHERE "Phone Service" == 'No';

--Check NULL Values in Column Phone Service
SELECT DISTINCT
	"Internet Type",
	"Avg Monthly GB Download",
	"Online Security",
	"Online Backup",
	"Device Protection Plan",
	"Premium Tech Support",
	"Streaming TV",
	"Streaming Movies",
	"Streaming Music",
	"Unlimited Data"
FROM telecom_customer_churn
WHERE "Internet Service" == 'No';

--Deal With Null Values
---Create new table
CREATE TABLE "cleaned_df" (
	"Customer ID"	TEXT,
	"Gender"	TEXT,
	"Age"	INTEGER,
	"Married"	TEXT,
	"Number of Dependents"	INTEGER,
	"City"	TEXT,
	"Zip Code"	INTEGER,
	"Latitude"	REAL,
	"Longitude"	REAL,
	"Number of Referrals"	INTEGER,
	"Tenure in Months"	INTEGER,
	"Offer"	TEXT,
	"Phone Service"	TEXT,
	"Avg Monthly Long Distance Charges"	TEXT,
	"Multiple Lines"	TEXT,
	"Internet Service"	TEXT,
	"Internet Type"	TEXT,
	"Avg Monthly GB Download"	INTEGER,
	"Online Security"	TEXT,
	"Online Backup"	TEXT,
	"Device Protection Plan"	TEXT,
	"Premium Tech Support"	TEXT,
	"Streaming TV"	TEXT,
	"Streaming Movies"	TEXT,
	"Streaming Music"	TEXT,
	"Unlimited Data"	TEXT,
	"Contract"	TEXT,
	"Paperless Billing"	TEXT,
	"Payment Method"	TEXT,
	"Monthly Charge"	REAL,
	"Total Charges"	REAL,
	"Total Refunds"	INTEGER,
	"Total Extra Data Charges"	INTEGER,
	"Total Long Distance Charges"	INTEGER,
	"Total Revenue"	REAL,
	"Customer Status"	TEXT,
	"Churn Category"	TEXT,
	"Churn Reason"	TEXT
);

--Insert clean data
INSERT INTO cleaned_df
SELECT
	"Customer ID",
	"Gender",
	"Age",
	"Married",
	"Number of Dependents",
	"City",
	"Zip Code",
	"Latitude",
	"Longitude",
	"Number of Referrals",
	"Tenure in Months",
	"Offer",
	"Phone Service",
	COALESCE("Avg Monthly Long Distance Charges", 0) AS "Avg Monthly Long Distance Charges",
	COALESCE("Multiple Lines",'No') AS "Multiple Lines",
	"Internet Service",
	COALESCE("Internet Type", 'No') AS "Internet Type",
	COALESCE("Avg Monthly GB Download", 0) AS "Avg Monthly GB Download",
	COALESCE("Online Security", 'No') AS "Online Security",
	COALESCE("Online Backup", 'No') AS "Online Backup",
	COALESCE("Device Protection Plan", 'No') AS "Device Protection Plan",
	COALESCE("Premium Tech Support", 'No') AS "Premium Tech Support",
	COALESCE("Streaming TV", 'No') AS "Streaming TV",
	COALESCE("Streaming Movies", 'No') AS "Streaming Movies",
	COALESCE("Streaming Music", 'No') AS "Streaming Music",
	COALESCE("Unlimited Data", 'No') AS "Unlimited Data",
	"Contract",
	"Paperless Billing",
	"Payment Method",
	"Monthly Charge",
	"Total Charges",
	"Total Refunds",
	"Total Extra Data Charges",
	"Total Long Distance Charges",
	"Total Revenue",
	"Customer Status",
	COALESCE("Churn Category", 'Others') AS "Churn Category",
	COALESCE("Churn Reason", 'Others') AS "Churn Reason"
FROM telecom_customer_churn;

--Check new table
SELECT
	COUNT(*),
	SUM(CASE WHEN "Customer ID" IS NULL THEN 1 ELSE 0 END) AS "Customer ID Nulls",
	SUM(CASE WHEN "Gender" IS NULL THEN 1 ELSE 0 END) AS "Gender Nulls",
	SUM(CASE WHEN "Age" IS NULL THEN 1 ELSE 0 END) AS "Age Nulls",
	SUM(CASE WHEN "Married" IS NULL THEN 1 ELSE 0 END) AS "Married Nulls",
	SUM(CASE WHEN "Number of Dependents" IS NULL THEN 1 ELSE 0 END) AS "Number of Dependents Nulls",
	SUM(CASE WHEN "City" IS NULL THEN 1 ELSE 0 END) AS "City Nulls",
	SUM(CASE WHEN "Zip Code" IS NULL THEN 1 ELSE 0 END) AS "Zip Code Nulls",
	SUM(CASE WHEN "Latitude" IS NULL THEN 1 ELSE 0 END) AS "Latitude Nulls",
	SUM(CASE WHEN "Longitude" IS NULL THEN 1 ELSE 0 END) AS "Longitude Nulls",
	SUM(CASE WHEN "Number of Referrals" IS NULL THEN 1 ELSE 0 END) AS "Number of Referrals Nulls",
	SUM(CASE WHEN "Tenure in Months" IS NULL THEN 1 ELSE 0 END) AS "Tenure in Months Nulls",
	SUM(CASE WHEN "Offer" IS NULL THEN 1 ELSE 0 END) AS "Offer Nulls",
	SUM(CASE WHEN "Phone Service" IS NULL THEN 1 ELSE 0 END) AS "Phone Service Nulls",
	SUM(CASE WHEN "Avg Monthly Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS "Avg Monthly Long Distance Charges Nulls",
	SUM(CASE WHEN "Multiple Lines" IS NULL THEN 1 ELSE 0 END) AS "Multiple Lines Nulls",
	SUM(CASE WHEN "Internet Service" IS NULL THEN 1 ELSE 0 END) AS "Internet Service Nulls",
	SUM(CASE WHEN "Internet Type" IS NULL THEN 1 ELSE 0 END) AS "Internet Type Nulls",
	SUM(CASE WHEN "Avg Monthly GB Download" IS NULL THEN 1 ELSE 0 END) AS "Avg Monthly GB Download Nulls",
	SUM(CASE WHEN "Online Security" IS NULL THEN 1 ELSE 0 END) AS "Online Security Nulls",
	SUM(CASE WHEN "Online Backup" IS NULL THEN 1 ELSE 0 END) AS "Online Backup Nulls",
	SUM(CASE WHEN "Device Protection Plan" IS NULL THEN 1 ELSE 0 END) AS "Device Protection Plan Nulls",
	SUM(CASE WHEN "Premium Tech Support" IS NULL THEN 1 ELSE 0 END) AS "Premium Tech Support Nulls",
	SUM(CASE WHEN "Streaming TV" IS NULL THEN 1 ELSE 0 END) AS "Streaming TV Nulls",
	SUM(CASE WHEN "Streaming Movies" IS NULL THEN 1 ELSE 0 END) AS "Streaming Movies Nulls",
	SUM(CASE WHEN "Streaming Music" IS NULL THEN 1 ELSE 0 END) AS "Streaming Music Nulls",
	SUM(CASE WHEN "Unlimited Data" IS NULL THEN 1 ELSE 0 END) AS "Unlimited Data Nulls",
	SUM(CASE WHEN "Contract" IS NULL THEN 1 ELSE 0 END) AS "Contract Nulls",
	SUM(CASE WHEN "Paperless Billing" IS NULL THEN 1 ELSE 0 END) AS "Paperless Billing Nulls",
	SUM(CASE WHEN "Payment Method" IS NULL THEN 1 ELSE 0 END) AS "Payment Method Nulls",
	SUM(CASE WHEN "Monthly Charge" IS NULL THEN 1 ELSE 0 END) AS "Monthly Charge Nulls",
	SUM(CASE WHEN "Total Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Charges Nulls",
	SUM(CASE WHEN "Total Refunds" IS NULL THEN 1 ELSE 0 END) AS "Total Refunds Nulls",
	SUM(CASE WHEN "Total Extra Data Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Extra Data Charges Nulls",
	SUM(CASE WHEN "Total Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS "Total Long Distance Charges Nulls",
	SUM(CASE WHEN "Total Revenue" IS NULL THEN 1 ELSE 0 END) AS "Total Revenue Nulls",
	SUM(CASE WHEN "Customer Status" IS NULL THEN 1 ELSE 0 END) AS "Customer Status Nulls",
	SUM(CASE WHEN "Churn Category" IS NULL THEN 1 ELSE 0 END) AS "Churn Category Nulls",
	SUM(CASE WHEN "Churn Reason" IS NULL THEN 1 ELSE 0 END) AS "Churn Reason Nulls"
FROM cleaned_df;