SELECT Gender, COUNT(Gender), Depression
FROM [Depression Student Dataset]
GROUP BY Depression, Gender

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
SELECT Sleep_Duration, Study_Satisfaction, 
       AVG(CASE 
		WHEN Have_you_ever_had_suicidal_thoughts = 'Yes' THEN 1 
		ELSE 0 END
		) AS Suicidal_Thoughts_Rate 
FROM [Depression Student Dataset] 
GROUP BY Sleep_Duration, Study_Satisfaction;





SELECT *
FROM [Depression Student Dataset]