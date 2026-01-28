-- ***************************************
-- Data Cleaning Steps Taken
-- ***************************************
-- 1. Check for and remove duplicates
-- 2. Standardize data and fix errors
-- 3. Look at null values 
-- 4. Remove irrelevant columns and rows

SELECT * FROM layoffs.layoffs;

-- ******************************************************
-- Create a staging table to use for cleaning the data
-- ******************************************************

CREATE TABLE layoffs.layoffs_staging
LIKE layoffs.layoffs;

SELECT * from layoffs.layoffs_staging; 

INSERT INTO `layoffs`.`layoffs_staging` (
`company`, `location`, `total_laid_off`, 
`date`, `percentage_laid_off`, `industry`, 
`source`, `stage`, `funds_raised`, 
`country`, `date_added`)
SELECT * FROM layoffs.layoffs;

SELECT * FROM layoffs.layoffs_staging;

-- *******************************
--  Step 1: Remove the duplicates
-- *******************************

-- use the window function row_number() to see if there are any rows with duplicates 
-- partitioning by all columns except the `source` and `date_added` columns. 
-- The two columns are excluded because the same company layoff can be added to the 
-- dataset by different sources on different dates.
SELECT * 
FROM (
	SELECT `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `source`, `stage`, `funds_raised`, `country`, `date_added`,
		ROW_NUMBER() OVER( 
			PARTITION BY `company`, `location`, `total_laid_off`, 
			`date`, `percentage_laid_off`, `industry`, `stage`, 
			`funds_raised`, `country`) AS row_num
	FROM layoffs.layoffs_staging
) AS layoffs_duplicates 
WHERE row_num > 1;

-- view the companies with duplicates to verify if they are duplicate values before removing them 
SELECT * 
FROM layoffs.layoffs_staging
WHERE company IN ('Beyond Meat', 'Cars24', 'Cazoo')
ORDER BY company, `date`;

-- create a second staging table with a row number column added to remove duplicate values
CREATE TABLE layoffs.layoffs_staging2 (
  `company` text,
  `location` text,
  `total_laid_off` double DEFAULT NULL,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs.layoffs_staging2;

INSERT INTO layoffs.layoffs_staging2
SELECT `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `source`, `stage`, `funds_raised`, `country`, `date_added`,
		ROW_NUMBER() OVER( 
			PARTITION BY `company`, `location`, `total_laid_off`, 
			`date`, `percentage_laid_off`, `industry`, `stage`, 
			`funds_raised`, `country`) AS row_num
	FROM layoffs.layoffs_staging;
    
SELECT * 
FROM layoffs.layoffs_staging2;

-- Remove the duplicates from the second staging table
DELETE 
FROM layoffs.layoffs_staging2
WHERE row_num > 1;

-- ******************************************
-- Step 2: Standardize data and fix errors
-- ******************************************

-- 1. company column
SELECT DISTINCT company
FROM layoffs.layoffs_staging2;

-- remove whitespace 
UPDATE layoffs.layoffs_staging2
SET company = TRIM(company);

-- 2. location column
SELECT DISTINCT location
FROM layoffs.layoffs_staging2
ORDER BY location;

-- remove the ', Non-U.S.' substring as the dataset states which country a location is from
SELECT DISTINCT location, TRIM(TRAILING ', Non-U.S.' FROM location)
FROM layoffs.layoffs_staging2
ORDER BY location;

UPDATE layoffs.layoffs_staging2
SET location = TRIM(TRAILING ', Non-U.S.' FROM location);

-- 3. date columns
-- convert date and date_added column data type from text to date
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs.layoffs_staging2;

UPDATE layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date_added`, STR_TO_DATE(`date_added`, '%m/%d/%Y')
FROM layoffs.layoffs_staging2;

UPDATE layoffs.layoffs_staging2
SET `date_added` = STR_TO_DATE(`date_added`, '%m/%d/%Y');

ALTER TABLE layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE,
MODIFY COLUMN `date_added` DATE;

-- 4. industry column
-- only one value with no industry set and the company has one layoff entry, hence there is no other record to used to fill in the missing value. 

-- 5. source column
UPDATE layoffs.layoffs_staging2
SET `source` = TRIM(`source`);

-- 7. funds_raised column
-- rename column for clarity 
ALTER TABLE layoffs.layoffs_staging2
RENAME COLUMN funds_raised 
TO funds_raised_million;

-- 8. country column
SELECT DISTINCT country
FROM layoffs.layoffs_staging2
ORDER BY country;

-- set all companies in the country UAE to United Arab Emirates
SELECT * 
FROM layoffs.layoffs_staging2
WHERE country IN ('UAE', 'United Arab Emirates');

UPDATE layoffs.layoffs_staging2
SET country = 'United Arab Emirates'
WHERE country = 'UAE';

-- ******************************
-- Step 3: Look at null values
-- ******************************

-- 1. stage column
SELECT DISTINCT stage
FROM layoffs.layoffs_staging2
ORDER BY stage;

SELECT * 
FROM layoffs.layoffs_staging2
WHERE stage = '';

SELECT * 
FROM layoffs.layoffs_staging2
WHERE company = 'Advata';

UPDATE layoffs.layoffs_staging2
SET stage = 'Unknown'
WHERE stage = '';

-- 2. country column
SELECT * 
FROM layoffs.layoffs_staging2
WHERE country = '';
 
SELECT * 
FROM layoffs.layoffs_staging2
WHERE location = 'Montreal';

UPDATE layoffs.layoffs_staging2
SET country = 'Canada'
WHERE country = '' AND location = 'Montreal';

-- *********************************************
-- Step 4: Remove irrelevant columns and rows
-- *********************************************

ALTER TABLE layoffs.layoffs_staging2
DROP COLUMN row_num;

SELECT * FROM layoffs.layoffs_staging2;

SELECT * FROM layoffs.layoffs;
