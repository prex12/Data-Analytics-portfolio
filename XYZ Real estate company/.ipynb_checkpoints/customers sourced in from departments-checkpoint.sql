WITH r_agency AS
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY Realtor, Department, Time_of_Resumption, Time_of_Exit, "Date", Hours_Spent, Customers_Brought_In 
ORDER BY Realtor, Department, Time_of_Resumption, Time_of_Exit, "Date", Hours_Spent, Customers_Brought_In) AS Dup
FROM real_estate_agency_data
)
SELECT *
FROM r_agency
WHERE Dup > 1

-- No duplicates

-- Standardize data


-- EDA
SELECT Department, SUM(Customers_Brought_In) total_sales
FROM real_estate_agency_data
GROUP BY Department
ORDER BY total_sales DESC

-- the Property management team brought in the most customers

SELECT Realtor, SUM(Customers_Brought_In) total_customer_per_person
FROM real_estate_agency_data
GROUP BY Realtor
ORDER BY total_customer_per_person

-- Charlie Brown made the most sales ove the months

SELECT Realtor, SUM(Hours_Spent) total_hours_per_person
FROM real_estate_agency_data
GROUP BY Realtor
ORDER BY total_hours_per_person

SELECT *
FROM real_estate_agency_data