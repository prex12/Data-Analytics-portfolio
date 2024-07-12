-- remove duplicates


WITH layoff_CTE AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
	date, stage, country, funds_raised_millions ORDER BY company, location, industry, total_laid_off, 
	percentage_laid_off, date, stage, country, funds_raised_millions) AS row_count
	FROM layoffs_staging
)
SELECT *
FROM layoff_CTE


SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
	date, stage, country, funds_raised_millions ORDER BY company, location, industry, total_laid_off, 
	percentage_laid_off, date, stage, country, funds_raised_millions) AS row_count
	INTO layoffs_staging2
	FROM layoffs_staging

DELETE
FROM layoffs_staging2
WHERE row_count > 1

SELECT DISTINCT(TRIM(company)) AS company_fixed
FROM layoffs_staging2

UPDATE layoffs_staging2
SET company = TRIM(company)

-- Standardize data

SELECT industry
FROM layoffs_staging2
WHERE industry LIKE 'cryp%'

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'cryp%'

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country = 'United States.'


-- ALTERing and converting the date column
SELECT * 
FROM layoffs_staging3
WHERE TRY_CONVERT(date, "date") IS NULL

ALTER TABLE layoffs_staging3
ADD UpdatedDate_New date NULL;

SELECT *
FROM layoffs_staging3
WHERE UpdatedDate_New IS NULL

UPDATE layoffs_staging3
SET UpdatedDate_New = TRY_CONVERT(date, "date")

ALTER TABLE layoffs_staging3
DROP COLUMN "date"

-- check and fix NULL and empty values

SELECT *
FROM layoffs_staging3
WHERE industry IS NULL OR industry = ''

SELECT *
FROM layoffs_staging3
WHERE company LIKE 'Airb%'

SELECT *
FROM layoffs_staging3
WHERE company LIKE 'carv%'

SELECT *
FROM layoffs_staging3
WHERE company LIKE 'Juu%'


	-- the below shows us where is NULL or empty in the first table and is NOT NULL in the next table
SELECT *
FROM layoffs_staging3 t1
JOIN layoffs_staging3 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL

	-- to update the table now
	-- we joined the table to itself so that we can extract the values of cells that are NOT NULL and update
	-- the old table with them

UPDATE t1

SET t1.industry = t2.industry
FROM layoffs_staging3 t1

JOIN layoffs_staging3 t2
	ON t1.company = t2.company
	WHERE (t1.industry IS NULL OR t1.industry = '')
	AND t2.industry IS NOT NULL

SELECT *
FROM layoffs_staging3
WHERE (percentage_laid_off IS NULL OR percentage_laid_off = '')
AND (total_laid_off IS NULL OR total_laid_off = '')

ALTER TABLE layoffs_staging3
ADD id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY

ALTER TABLE layoffs_staging3
DROP COLUMN row_count


SELECT *
FROM layoffs_staging3

-- EDA PROECESS

SELECT industry, SUM(total_laid_off) sum_laid_off_per_country, AVG(total_laid_off) average_laid_off_per_country
FROM layoffs_staging3
GROUP BY industry
ORDER BY 2 DESC

SELECT MAX(total_laid_off)
FROM layoffs_staging3

SELECT *
FROM layoffs_staging3
WHERE total_laid_off >= 12000

SELECT SUBSTRING(CONVERT(VARCHAR, UpdatedDate_new, 112), 1, 7)
FROM layoffs_staging3

SELECT *
FROM layoffs_staging3
WHERE UpdatedDate_New IS NOT NULL
ORDER BY UpdatedDate_New ASC

SELECT company, "location", country, total_laid_off, UpdatedDate_New
FROM layoffs_staging3
ORDER BY total_laid_off DESC

SELECT company, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company
ORDER BY 1 ASC

SELECT *
FROM layoffs_staging3
WHERE company = 'Google'