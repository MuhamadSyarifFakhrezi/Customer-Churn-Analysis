# Customer Churn Analysis
## Table of Contents
1. [Project Overview](##Project-Overview)
2. [Tools](##Tools)
3. [Dataset](##Dataset)
4. [Process](##Process)
5. [Exploratory Data Analysis](##Exploratory-Data-Analysis)
6. [Visualization](##Visualization)
7. [Model](##Model)
8. [Conclusion and Recommendation](##Conclusion-and-Recommendation)
9. [Cara Menjalankan Proyek](#cara-menjalankan-proyek)
10. [Kontribusi](#kontribusi)

## Project Overview


## Tools
- **SQL**: Data wrangling and EDA.
- **Tableau**: Data visualisation.
- **Python**: To build a churn prediction model.
- **Libraries Python**: Pandas, Numpy, Scikit-learn, Gradient Boosting, Matplotlib, Seaborn.

## Dataset
| FEATURE | DESCRIPTION |
| --- | --- |
| CustomerID |	A unique ID that identifies each customer |
| Gender |	The customer's gender: Male, Female |
|	Age |	The customer's current age, in years, at the time the fiscal quarter ended (Q2 2022) |
|	Married |	Indicates if the customer is married: Yes, No |
| Number of Dependents |	Indicates the number of dependents that live with the customer (dependents could be children, parents, etc) |
|	City |	The city of the customer's primary residence in California |
|	Zip Code |	The zip code of the customer's primary residence |
|	Latitude |	The latitude of the customer's primary residence |
|	Longitude |	The longitude of the customer's primary residence |
|	Number of Referrals |	Indicates the number of times the customer has referred a friend or family member to this company to date |
|	Tenure in Months |	Indicates the total amount of months that the customer has been with the company by the end of the quarter specified above |
|	Offer |	Identifies the last marketing offer that the customer accepted: None, Offer A, Offer B, Offer C, Offer D, offer E |
| Phone Service | Indicates if the customer subscribes to home phone service with the company: Yes, No |
|	Avg Monthly Long Distance Charges | Indicates the customer's average long distance charges, calculated to the end of the quarter specified above (if the customer is not subscribed to home phone service, this will be 0) |
|	Multiple Lines | Indicates if the customer subscribes to multiple telephone lines with the company: Yes, No (if the customer is not subscribed to home phone service, this will be No) |
|	Internet Service | Indicates if the customer subscribes to Internet service with the company: Yes, No |
|	Internet Type | Indicates the customer's type of internet connection: DSL, Fiber Optic, Cable ((if the customer is not subscribed to internet service, this will be None)
|	Avg Monthly GB Download | Indicates the customer’s average download volume in gigabytes, calculated to the end of the quarter specified above (if the customer is not subscribed to internet service, this will be 0) |
|	Online Security | Indicates if the customer subscribes to an additional online backup service provided by the company: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Online Backup | Indicates if the customer subscribes to an additional online backup service provided by the company: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Device Protection Plan |	Indicates if the customer subscribes to an additional device protection plan for their Internet equipment provided by the company: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Premium Tech Support | Indicates if the customer subscribes to an additional technical support plan from the company with reduced wait times: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Streaming TV | Indicates if the customer uses their Internet service to stream television programing from a third party provider at no additional fee: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Streaming Movies |	Indicates if the customer uses their Internet service to stream movies from a third party provider at no additional fee: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Streaming Music | Indicates if the customer uses their Internet service to stream music from a third party provider at no additional fee: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Unlimited Data | Indicates if the customer has paid an additional monthly fee to have unlimited data downloads/uploads: Yes, No (if the customer is not subscribed to internet service, this will be No) |
|	Contract | Indicates the customer's current contract type: Month-to-Month, One Year, Two Year |
|	Paperless Billing | Indicates if the customer has chosen paperless billing: Yes, No |
|	Payment Method |Indicates how the customer pays their bill: Bank Withdrawal, Credit Card, Mailed Check |
|	Monthly Charge | Indicates the customer's current total monthly charge for all their services from the company |
|	Total Charges | Indicates the customer's total charges, calculated to the end of the quarter specified above |
|	Total Refunds | Indicates the customer's total refunds, calculated to the end of the quarter specified above |
|	Total Extra Data Charges | Indicates the customer’s total charges for extra data downloads above those specified in their plan, by the end of the quarter specified above |
|	Total Long Distance Charges | Indicates the customer’s total charges for long distance above those specified in their plan, by the end of the quarter specified above |
|	Total Revenue | Indicates the company's total revenue from this customer, calculated to the end of the quarter specified above (Total Charges - Total Refurnds + Total Extra Data Charges + Total Lond Distance Charges) |
| Customer Status | Indicates the status of the customer at the end of the quarter: Churned, Stayed, or Joined |
| Churn Category | A high-level category for the customer’s reason for churning, which is asked when they leave the company: Attitude, Competitor, Dissatisfaction, Other, Price (directly related to Churn Reason) |
|	Churn Reason | A customer’s specific reason for leaving the company, which is asked when they leave the company (directly related to Churn Category) |

**Data Source Link:** [Link](https://www.kaggle.com/datasets/shilongzhuang/telecom-customer-churn-by-maven-analytics/data?) 

## Process
- Collect the data
- Exploratory Data Analysis
- Data Preprocessing and cleaning
- Deploying visualizations with Tableau
- Feature engineering, labeling, and scaling
- Model training and hyperparameter tuning
- Evaluation
- Prediction test and model improvements
- Conclusion and article writing

## Exploratory Data Analysis
- **How many customers churned?**
```
--The number of customers by customer status
SELECT 
	"Customer Status", 
	COUNT(*) AS "Customer Count", 
	ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM telecom_customer_churn
GROUP BY 1;
```

![Screenshot (994)](https://github.com/user-attachments/assets/2899624e-9e1c-49d4-83aa-d7f953de9942)

The company has lost 1869 customers which is 27% of the total customers it had before. 

- **How much revenue is lost due to churned customer?**
```
--Lost revenue due to churned customers
SELECT
	"Customer Status",
	SUM("Total Revenue") AS "Total Revenue",
	ROUND(100.0 * SUM("Total Revenue") / SUM(SUM("Total Revenue")) OVER(), 2) AS "Percentage of Total Revenue"
FROM telecom_customer_churn
GROUP BY 1;
```

![Screenshot (993)](https://github.com/user-attachments/assets/af13339d-6dd6-41a0-a934-6ea40a083114)

Of the 1869 churned customers, they have accounted for 17% of the company's total revenue.

- **What type of tenure has the high churn rate?**
```
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
```

![Screenshot (995)](https://github.com/user-attachments/assets/202bca4d-f3f4-4183-a63f-299a49fcd2a7)

I found that 53% of churned customers spent 6 months or less before leaving, more than half of the customers who churned had a relatively short tenure with the company.

- **What type of offer has the high churn rate?**
```
--Churn rate by offer
SELECT
	Offer,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;
```

![Screenshot (996)](https://github.com/user-attachments/assets/3458d9c3-5a1c-42ad-8c58-181ad79c7a71)

Customers who got the E offer had the highest churn rate of 53%, which is higher than customers who did not get the offer who only had a churn rate of 27%.

- **What type of contract has the highest churn rate?**
```
--Churn rate by contract
SELECT
	Contract,
	COUNT(*) AS "Number of Customers",
	SUM(CASE WHEN "Customer Status" == "Churned" THEN 1 ELSE 0 END) AS "Churned Customer",
	ROUND(100.0 * COUNT(CASE WHEN "Customer Status" == "Churned" THEN "Customer ID" ELSE NULL END) / COUNT("Customer ID"), 2) AS "Churn Rate"
FROM telecom_customer_churn
GROUP BY 1
ORDER BY 4 DESC;
```

![Screenshot (997)](https://github.com/user-attachments/assets/6ad3b2f7-a544-4fa3-bccb-5211ae836442)

Customers on month-to-month contract have the highest churn rate at 46%.

- **Which city has the highest churn rate?**
```
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
```

![Screenshot (998)](https://github.com/user-attachments/assets/838ab1bb-bc81-4285-a0d7-3f6f815bea2a)

San Diego had the highest churn rate at 65%, which means that over half of their customers have left the company.

- **Which age category has the high churn rate?**
```
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
```

![Screenshot (999)](https://github.com/user-attachments/assets/8bc7c751-b35a-47e1-b882-ad82e5fd8ad2)

In the age category, we found that the older the customer, the greater the churn rate.

- **What are the underlying reasons for churn?**
```
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
```

![Screenshot (1000)](https://github.com/user-attachments/assets/35f718c4-2581-43b4-aae2-4fca159f2b86)

The top 5 reasons why customers churn are 'Competitor made better offer', 'Competitor had better devices', 'Attitude of support person', 'Don't know', and 'Competitor offered more data'.

## Visualization
![Screenshot (992)](https://github.com/user-attachments/assets/92dc3645-78f8-4690-9231-dca4debeb5dc)

## Model
![accuracy model](https://github.com/user-attachments/assets/0351be9f-857a-490d-86a7-ee6a036fe48c)

![confusion matrix](https://github.com/user-attachments/assets/93e02611-8420-464c-b59c-13fb51d22629)

## Conclusion and Recomenndation
