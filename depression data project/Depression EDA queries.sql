SELECT Gender, COUNT(Gender), Depression
FROM [Depression Student Dataset]
GROUP BY Depression, Gender

-- Average ages of people in the dataset is 26
SELECT AVG(Age) average_age
FROM [Depression Student Dataset]

-- Age distrubution
SELECT Age, COUNT(Age) number_in_group
FROM [Depression Student Dataset]
GROUP BY Age
ORDER BY Age

-- correlating study satisfaction and study hours to depression
SELECT Depression, AVG(Study_Hours) AS Avg_Study_Hours 
FROM [Depression Student Dataset]
GROUP BY Depression;

SELECT Depression, AVG(Study_Satisfaction) Avg_study_satisfaction
FROM [Depression Student Dataset]
GROUP BY Depression;

-- Dietary habits and depression
SELECT Dietary_Habits, Depression, COUNT(Depression) Number_of_people
FROM [Depression Student Dataset]
-- WHERE Depression = 'Yes'
GROUP BY Dietary_Habits, Depression

UPDATE [Depression Student Dataset]
SET Sleep_Duration =
CASE
	WHEN Sleep_Duration = 'More than 8 hours' THEN '8'
	WHEN Sleep_Duration = 'Less than 5 hours' THEN '5'
	WHEN Sleep_Duration = '5-6 hours' THEN '6'
	WHEN Sleep_Duration = '7-8 hours' THEN '7'
END

ALTER TABLE [Depression Student Dataset]
ALTER COLUMN Sleep_Duration int

-- Relationship between Suicidal thoughts and study satisfaction
SELECT Sleep_Duration, Study_Satisfaction, COUNT(Sleep_Duration),
       AVG(CASE 
			WHEN Have_you_ever_had_suicidal_thoughts = 'Yes' THEN 1 
			ELSE 0
		END
		) AS Suicidal_Thoughts_Rate 
FROM [Depression Student Dataset]
GROUP BY Sleep_Duration, Study_Satisfaction, Have_you_ever_had_suicidal_thoughts
HAVING Have_you_ever_had_suicidal_thoughts = 'Yes'


-- High academic pressure relatioinship to study satisfaction
SELECT Academic_Pressure, AVG(Study_Satisfaction) average_study_satisfaction
FROM [Depression Student Dataset]
WHERE Academic_Pressure >= 4
GROUP BY Academic_Pressure;

-- Financial stress and its relationship with depression
SELECT Financial_Stress, COUNT(*) AS Count, 
       SUM(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) AS Depressed_Count 
FROM [Depression Student Dataset] 
GROUP BY Financial_Stress;


-- Relationship btw dietary habits and sleep hours more or less the same accross the board
SELECT Dietary_Habits, AVG(Sleep_Duration) Average_sleep
FROM [Depression Student Dataset]
GROUP BY Dietary_Habits

-- Sleep and study satisfation
SELECT Sleep_Duration, AVG(Study_Satisfaction) avg_satisfaction
FROM [Depression Student Dataset]
GROUP BY Sleep_Duration

-- avg study hours of individuals with high study satisfaction = 6 hours
SELECT AVG(Study_Hours) avg_hours, Study_Satisfaction
FROM [Depression Student Dataset]
WHERE Study_Satisfaction >= 4
GROUP BY Study_Satisfaction

SELECT Family_History_of_Mental_Illness, Depression
FROM [Depression Student Dataset]
WHERE Family_History_of_Mental_Illness = 'Yes';


SELECT *
FROM [Depression Student Dataset];