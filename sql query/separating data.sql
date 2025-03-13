CREATE VIEW churn_data AS
	SELECT * FROM cleaned_df WHERE "Customer Status" IN ('Churned', 'Stayed');
	
CREATE VIEW join_data AS
	SELECT * FROM cleaned_df WHERE "Customer Status" == 'Joined';