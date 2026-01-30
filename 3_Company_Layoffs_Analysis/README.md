# Company Layoffs Data Cleaning & Exploratory Data Analysis

## Contents

- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)

## Data Cleaning

> **Before cleaning**

![Preview of dataset before cleaning](https://github.com/user-attachments/assets/0eac5e0f-7197-470d-9330-17fa8861a3ac)

> **After cleaning**

![Preview of clean dataset](https://github.com/user-attachments/assets/8f87b7b9-74da-4261-b9ad-1f27f5bcbab8)

### Steps I Took To Clean The Data

1. [Create a staging table](#1%EF%B8%8F⃣-staging-table)
2. [Check for and remove duplicates](#2%EF%B8%8F⃣-removing-duplicates)
3. [Standardise data and fix errors](#3%EF%B8%8F⃣-standardising-data)
4. [Look at null values](#4%EF%B8%8F⃣-managing-null-values)
5. [Remove irrelevant columns and rows](#5%EF%B8%8F⃣-removing-irrelevant-data)

### 1️⃣ Staging Table

I created a duplicate table `layoffs_staging` to use to clean the data and avoid altering the original dataset.

```sql
CREATE TABLE layoffs.layoffs_staging
LIKE layoffs.layoffs;

INSERT INTO `layoffs`.`layoffs_staging` (
`company`, `location`, `total_laid_off`,
`date`, `percentage_laid_off`, `industry`,
`source`, `stage`, `funds_raised`,
`country`, `date_added`)
SELECT * FROM layoffs.layoffs;
```

### 2️⃣ Removing Duplicates

#### Step 1: Using a window function to identify duplicates

- I used the window function `row_number()` to identify duplicate rows.
- I partitioned by all columns except the `source` and `date_added` columns. I excluded the two columns because the same company layoff can be added to the dataset by different sources on different dates.

```sql
SELECT *
FROM (
    SELECT `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `source`, `stage`, `funds_raised`, `country`, `date_added`,
    ROW_NUMBER() OVER(
    PARTITION BY `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `stage`, `funds_raised`, `country`) AS row_num
    FROM layoffs.layoffs_staging
) AS layoffs_duplicates
WHERE row_num > 1;
```

![Company layoff duplicate rows](https://github.com/user-attachments/assets/fb2c831b-3c83-4ea1-956d-b9e7f6d48ac2)

#### Step 2: Verifying duplicates

I queried the data to view the companies in with duplicate rows to verify the duplicate values.

```sql
SELECT *
FROM layoffs.layoffs_staging
WHERE company IN ('Beyond Meat', 'Cars24', 'Cazoo')
ORDER BY company, `date`;
```

![Verifying duplicate values](https://github.com/user-attachments/assets/a32ba00f-a8d9-4002-b78c-1de3c2ddbdb4)

#### Step 3: Deleting duplicates

- I created a second staging table `layoffs_staging2`, which has a row number column added to remove the duplicate values seamlessly.
- I used the window function to insert all the data from `layoffs_staging` to `layoffs_staging2`, with the row numbers added.

```sql
INSERT INTO layoffs.layoffs_staging2
SELECT `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `source`, `stage`, `funds_raised`, `country`, `date_added`,
    ROW_NUMBER() OVER(
    PARTITION BY `company`, `location`, `total_laid_off`, `date`, `percentage_laid_off`, `industry`, `stage`, `funds_raised`, `country`) AS row_num
FROM layoffs.layoffs_staging;
```

```sql
DELETE
FROM layoffs.layoffs_staging2
WHERE row_num > 1;
```

### 3️⃣ Standardising Data

#### Step 1: Removing Whitespace

```sql
-- company & source column
UPDATE layoffs.layoffs_staging2
SET company = TRIM(company);

UPDATE layoffs.layoffs_staging2
SET `source` = TRIM(`source`);
```

#### Step 2: Removing Redundant Text

```sql
-- location column
-- remove the ', Non-U.S.' substring as the dataset states which country a location is from
UPDATE layoffs.layoffs_staging2
SET location = TRIM(TRAILING ', Non-U.S.' FROM location);
```

#### Step 3: Convert Date Columns to Date Data Type From Text

```sql
-- set to date format
UPDATE layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

UPDATE layoffs.layoffs_staging2
SET `date_added` = STR_TO_DATE(`date_added`, '%m/%d/%Y');

-- alter data types
ALTER TABLE layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE,
MODIFY COLUMN `date_added` DATE;
```

#### Step 4: Rename Columns

```sql
-- rename column for clarity
ALTER TABLE layoffs.layoffs_staging2
RENAME COLUMN funds_raised
TO funds_raised_million;
```

#### Step 5: Make Values Consistent

```sql
-- set all companies in the country UAE to United Arab Emirates
UPDATE layoffs.layoffs_staging2
SET country = 'United Arab Emirates'
WHERE country = 'UAE';
```

### 4️⃣ Managing Null Values

#### Step 1: Blank `stage` Column values

```sql
-- look at all the stage categories
SELECT DISTINCT stage
FROM layoffs.layoffs_staging2
ORDER BY stage;

-- set all the records with a blank stage value to the 'Unknown' category
UPDATE layoffs.layoffs_staging2
SET stage = 'Unknown'
WHERE stage = '';
```

#### Step 2: Blank `country` column values

- One record has an empty country value. However, the location value exists.
- With the assumption that a location is in a particular country, I used records from the same location to fill in the blank country value.

```sql
SELECT *
FROM layoffs.layoffs_staging2
WHERE country = '';
```

![Record with blank country value](https://github.com/user-attachments/assets/c734306d-5695-49a0-8edb-86694dfa3d89)

```sql
-- view layoffs in the same location
SELECT *
FROM layoffs.layoffs_staging2
WHERE location = 'Montreal';
```

![data of layoffs in the same location](https://github.com/user-attachments/assets/017a9907-e2fc-4d0b-a75b-bb9bc6e354ae)

```sql
-- set blank country value to 'Canada' because the location 'Montreal' is in Canada
UPDATE layoffs.layoffs_staging2
SET country = 'Canada'
WHERE country = '' AND location = 'Montreal';
```

### 5️⃣ Removing Irrelevant Data

I deleted the row number column `row_num` that was used to remove duplicates.

```sql
ALTER TABLE layoffs.layoffs_staging2
DROP COLUMN row_num;
```

## Exploratory Data Analysis
