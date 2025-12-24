# Analysis of Data Job Trends

## Introduction

### Problem

As data job seeker, breaking into the data profession can feel overwhelming. With so many skills to learn and career paths to choose from, it’s not always clear which investments in learning will pay off. This project is designed to give aspiring data professionals a clear picture of data job trends and set realistic career expectations.

### Objective

I sought to investigate the following questions:

1. Do data professionals with more skills earn a higher pay?
2. What is the median salary for data jobs in different regions?
3. What are the top skills of data professionals?
4. What is the median salary for the top 10 skills?

### Dashboard File

The complete analysis is in [Data_Job_Analysis.xlsx](https://github.com/beverly-m/Data-Analytics-Projects/blob/master/2_Job_Analysis/Data_Job_Analysis.xlsx)

### Dataset

The dataset comprises over 30,000 real-world job postings from 2023. The dataset is available via an [Excel for Data Analytics course by Luke Barousse](https://youtu.be/pCJ15nGFgVg?si=qicwLVMJyS4ycjqH).

It includes detailed information on job titles, salaries, locations, skills and posting platforms.

### Tools & Skills

I used the following **Excel** skills for analysis:

- 📊 Pivot Tables
- 📈 Pivot Charts
- 🧮 DAX (Data Analysis Expressions)
- 🔍 Power Query
- 💪 Power Pivot

## 1. Do data professionals with more skills earn a higher pay?

### Skills: `🔍 Power Query`

#### Extract

1️⃣ I used Power Query to extract the original data

2️⃣ Then I created two queries:

- the first with the data jobs' information `data_jobs_salary`
- the second with the list of the skills required for each job id `data_jobs_skills`

#### Transform

3️⃣ I then transformed each query by

- changing column types,
- removing unnecessary columns,
- splitting columns to create new ones,
- cleaning text to eliminate specific words
- trimming excess whitespace
- adding a job id column to uniquely identify each job entry

`data_jobs_salary`

`data_jobs_skills`

#### Load

4️⃣ Lastly, I loaded the queries into a workbook for further analysis.

`data_jobs_salary`

`data_jobs_skills`

### Analysis: Skills vs Salary

- There is a positive correlation between the number of skills requested per job posting and the median salary earned.
- Job titles requiring less skills such as business analysts offer a lower average salary than job titles demanding more skills such as data scientists.
- Although engineering roles demand more skills, their average salary is roughly similar and at times less than science and analytics roles.

#### Conclusion: Skills vs Salary

> 💡 To increase income, data professionals may focus on upskilling to increase their value in the job market. However, they should take into consideration that data scientist roles pay more with less skills required than data engineering roles.

## 2. What is the median salary for data jobs in different regions?

### Skills: `📊 Pivot Tables` `📈 Pivot Charts` `🧮 DAX`

#### Pivot Table and Pivot Chart

- I created a pivot table and pivot chart using the `data_jobs_salary` query.
- The rows are the job titles and the columns are the regional, US and Non-US median salary values calculated for each job title.
- I inserted a **slicer** to allow comparison of salaries for a selected region against US and Non-US median salaries.

#### DAX

I created the following measures to calculate the regional, US and Non-US median salary values.

```DAX
Median Salary:=MEDIAN(data_jobs_salary[salary_year_avg])

Median Salary US:=CALCULATE([Median Salary],data_jobs_salary[job_country] = "United States")

Median Salary Non-US:=CALCULATE([Median Salary], data_jobs_salary[job_country] <> "United States")
```

### Analysis: Australia, US and Non-US median salaries

## 3. What are the top skills of data professionals?

## 4. What is the median salary for the top 10 skills?
