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

#### Skills Salary Insights

- There is a positive correlation between the number of skills requested per job posting and the median salary earned.
- Job titles requiring less skills such as business analysts offer a lower average salary than job titles demanding more skills such as data scientists.
- Although engineering roles demand more skills, their average salary is roughly similar and at times less than science and analytics roles.

#### Skills Salary Conclusion

> 💡 To increase income, data professionals may focus on upskilling to increase their value in the job market. However, they should take into consideration that data scientist roles pay more with less skills required than data engineering roles.

## 2. What is the median salary for data jobs in different regions?

### Skills: `📊 Pivot Tables` `📈 Pivot Charts` `🧮 DAX`

#### Pivot Table and Pivot Chart

1️⃣ I created a pivot table and pivot chart using the `data_jobs_salary` query.

2️⃣ The rows are the job titles and the columns are the regional, US and Non-US median salary values calculated for each job title.

3️⃣ I inserted a **slicer** to allow comparison of salaries for a selected region against US and Non-US median salaries.

#### DAX

I created the following measures to calculate the regional, US and Non-US median salary values.

```DAX
Median Salary:=MEDIAN(data_jobs_salary[salary_year_avg])

Median Salary US:=CALCULATE([Median Salary],data_jobs_salary[job_country] = "United States")

Median Salary Non-US:=CALCULATE([Median Salary], data_jobs_salary[job_country] <> "United States")
```

### Analysis: Canada, US and Non-US median salaries

#### Median Salaries Insights

- Data job roles in Canada tend to pay within or slightly less than in the US and Non-US countries, excluding cloud engineering roles.
- Non-US countries have a significantly lower median salaries in cloud, software and machine learning engineering roles than Canada and the US.
- Job roles in data engineering and data science command higher median salaries globally, with Machine Learning and Cloud Engineering being among the top paying job roles in the US and Canada.

#### Median Salaries Conclusion

> 💡These salary insights reflect the need for data professionals to analyse market trends for planning and salary negotiations. This helps to be better informed on the value of different job roles across regions.

## 3. What are the top skills of data professionals?

### Skill: `💪 Power Pivot`

1️⃣ I created a data model by integrating the `data_jobs_all` and `data_jobs_skills` tables into one model.

2️⃣ Since I had already cleaned the data using Power Query; I used Power Pivot to create a relationship between these two tables using the `job_id` column.

3️⃣ I also used Power Pivot to refine the data model and create measures to calculate the likelihood of a skill being required.

```DAX
Skill Count:=COUNT(data_job_skills[job_skill])

Job Count:=DISTINCTCOUNT(data_jobs_salary[job_id])

Skill Likelihood:=DIVIDE([Skill Count], [Job Count])
```

4️⃣ I inserted slicers to allow comparison of skills for a selected region and job title.

### Analysis: Top skills for all data jobs globally

#### Top Skills Insights

- SQL and Python dominate as top skills in data-related jobs, reflecting their foundational role in data processing and analysis.
- There is a signficant demand for knowledge in cloud technologies such as AWS and Azure, and big data analytics tools such as Spark.

#### Top Skills Conclusion

Data professionals should invest in building knowledge on SQL and Python as they are highly used in the industry. They may also learn skills in big data analytics and cloud technologies to gain a competitive edge.

## 4. What is the median salary for the top 10 skills?

### Skills: `📈 Pivot Charts`

1️⃣ I created a combo PivotChart to plot median salary and skill likelihood (%) from a PivotTable.

**Primary Axis:** Median Salary (as a Clustered Column)

**Secondary Axis:** Skill Likelihood (as a Line with Markers)

2️⃣ To customize the chart, I removed the lines (skill likelihood), and changed the markers to diamonds.

3️⃣ I inserted slicers to allow comparison of skills for a selected region and job title.

### Analysis: Median salary of top skills

#### Top Skills Median Salary Insights

- Higher median salaries are associated with skills like Spark, AWS, and Java, suggesting their critical role in high-paying tech jobs. However, their skill likelihood is low, indicating that there are fewer jobs requiring these skills.
- Big data, cloud and programming skills have higher median salaries, whereas analytics and visualisation tools are at the bottom 10 median salaries.
- Skills in Python and SQL are both in demand and are required in jobs with relatively high median salary.

#### Top Skills Median Salary Conclusion

> 💡 Data professionals will benefit from investing time in learning high-value skills like Python and SQL, which are evidently tied to higher paying roles, if they are looking to maximize their salary in the tech industry. For more niche, higher paying roles, they may also look into the learning big data technologies like Spark.
