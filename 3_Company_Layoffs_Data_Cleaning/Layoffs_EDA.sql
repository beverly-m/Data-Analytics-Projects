SELECT * 
FROM layoffs.layoffs_staging2;

-- **********
-- OVERVIEW
-- **********

-- dataset date range 
SELECT MIN(`date`) AS earliest_date , MAX(`date`) AS latest_date
FROM layoffs.layoffs_staging2;

-- number of employees laid off over the years 
SELECT YEAR(`date`) AS `year`, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
GROUP BY `year`
ORDER BY `year`;

-- number of employees laid off over the years grouped by month
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`;

-- rolling total of employees laid off over the years grouped by month
WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month` ASC
)
SELECT `month`, sum_total_laid_off, 
SUM(sum_total_laid_off) OVER(ORDER BY `month`) AS rolling_total
FROM Rolling_Total;

-- the maximum number of employees laid off one instance
SELECT MAX(total_laid_off) AS max_employees_laid_off
FROM layoffs.layoffs_staging2;

-- the maximum percentage of employees laid off at a company
SELECT MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs.layoffs_staging2;

-- ***********
-- Companies
-- ***********

-- top 10 companies with the highest number of employees laid off since 2020
SELECT * 
FROM layoffs.layoffs_staging2
ORDER BY total_laid_off DESC
LIMIT 10;

-- top 10 companies with the highest number of employees laid off grouped by year
SELECT 
    company,
    industry,
    YEAR(`date`) AS `year`,
    SUM(total_laid_off) AS sum_total_laid_off
FROM
    layoffs.layoffs_staging2
WHERE
    total_laid_off IS NOT NULL
        AND `date` IS NOT NULL
GROUP BY company , industry , YEAR(`date`)
ORDER BY sum_total_laid_off DESC
LIMIT 10;

-- top 10 companies with the lowest number of employees laid off grouped by year
SELECT 
    company,
    industry,
    YEAR(`date`) AS `year`,
    SUM(total_laid_off) AS sum_total_laid_off
FROM
    layoffs.layoffs_staging2
WHERE
    total_laid_off IS NOT NULL
        AND `date` IS NOT NULL
GROUP BY company , industry , YEAR(`date`)
ORDER BY sum_total_laid_off ASC
LIMIT 10;


-- *************
-- Industries
-- *************

-- top 10 industries with the highest number of employees laid off since 2020
SELECT industry, 
	   SUM(total_laid_off) AS sum_total_laid_off 
FROM layoffs.layoffs_staging2
WHERE industry NOT IN ('')
GROUP BY industry
ORDER BY sum_total_laid_off DESC
LIMIT 10;

-- top 10 industries with the lowest number of employees laid off since 2020
SELECT industry, 
	   SUM(total_laid_off) AS sum_total_laid_off 
FROM layoffs.layoffs_staging2
WHERE industry NOT IN ('')
GROUP BY industry
ORDER BY sum_total_laid_off
LIMIT 10;

-- top 10 industries with the highest count of lay offs
SELECT 
    industry,
    SUM(total_laid_off) AS sum_total_laid_off,
    COUNT(total_laid_off) AS count_layoffs
FROM
    layoffs.layoffs_staging2
WHERE
    industry NOT IN ('')
GROUP BY industry
ORDER BY count_layoffs DESC
LIMIT 10;

-- top 10 industries with the lowest count of lay offs
SELECT 
    industry,
    SUM(total_laid_off) AS sum_total_laid_off,
    COUNT(total_laid_off) AS count_layoffs
FROM
    layoffs.layoffs_staging2
WHERE
    industry NOT IN ('')
GROUP BY industry
ORDER BY count_layoffs ASC
LIMIT 10;

-- *******
-- Stage
-- *******

-- number of employees laid off in each company stage sorted in descending order
SELECT 
    stage, SUM(total_laid_off) AS sum_total_laid_off
FROM
    layoffs.layoffs_staging2
GROUP BY stage
ORDER BY sum_total_laid_off DESC;

-- count of layoffs in each company stage sorted in descending order
SELECT 
    stage,
    SUM(total_laid_off) AS sum_total_laid_off,
    COUNT(total_laid_off) AS count_layoffs
FROM
    layoffs.layoffs_staging2
GROUP BY stage
ORDER BY count_layoffs DESC;

-- top 5 companies with the highest lay offs each year and their industries 
WITH Company_Year AS
(
SELECT company, 
industry,
YEAR(`date`) AS `year`, 
SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
WHERE total_laid_off IS NOT NULL AND `date` IS NOT NULL
GROUP BY company, industry, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, 
DENSE_RANK() OVER (PARTITION BY `year` ORDER BY sum_total_laid_off DESC) AS ranking
FROM Company_Year
) 
SELECT * 
FROM Company_Year_Rank
WHERE ranking <= 5
ORDER BY `year` DESC, ranking ASC;

-- top 5 companies with the lowest lay offs each year and their industries 
WITH Company_Year AS
(
SELECT company, 
industry,
YEAR(`date`) AS `year`, 
SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
WHERE total_laid_off IS NOT NULL AND `date` IS NOT NULL
GROUP BY company, industry, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, 
DENSE_RANK() OVER (PARTITION BY `year` ORDER BY sum_total_laid_off ASC) AS ranking
FROM Company_Year
) 
SELECT * 
FROM Company_Year_Rank
WHERE ranking <= 5
ORDER BY `year` DESC, ranking ASC;

-- companies that laid off all their employees
SELECT * 
FROM layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

WITH hundred_percent_laid_off AS
(
SELECT * 
FROM layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
) 
SELECT country, count(total_laid_off) AS count_layoffs, sum(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
GROUP BY country
ORDER BY count_layoffs DESC;

-- companies that laid off all their employees focusing on the funding their raised
SELECT * 
FROM layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_million DESC;

-- YOU WERE HERE
-- companies with the lowest lay offs
SELECT company, industry, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
GROUP BY company, industry
ORDER BY sum_total_laid_off DESC;

-- companies with the lowest lay offs
SELECT company, industry, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
GROUP BY company, industry
ORDER BY sum_total_laid_off;

-- OTHER QUERIES 
SELECT count(country) 
FROM layoffs.layoffs_staging2
WHERE country = 'United States';

SELECT DISTINCT stage 
FROM layoffs.layoffs_staging2;

SELECT industry, count(total_laid_off) as layoff_instances, sum(total_laid_off) as number_laid_off
FROM layoffs.layoffs_staging2
WHERE industry NOT IN ('')
GROUP BY industry
ORDER BY number_laid_off DESC;

SELECT * 
FROM layoffs.layoffs_staging2
WHERE company = 'Microsoft';

SELECT country, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs.layoffs_staging2
GROUP BY country
ORDER BY sum_total_laid_off DESC;
