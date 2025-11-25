# Data Jobs Salary Dashboard

_Screen recording of dashboard_

## Introduction

### Problem

Job seekers often face uncertainty when evaluating compensation offers, as salary information can be fragmented, outdated, or inconsistent across sources. Without clear insights into market pay ranges, individuals risk accepting positions with inadequate compensation relative to their skills, experience, and industry standards.

To address this challenge, I developed a job salary dashboard to visualize salary data, enabling job seekers to investigate pay trends for specific roles and make informed decisions about their career opportunities.

### Objective

To investigate salary trends of data jobs considering the job location and schedule (e.g. full-time or part-time).

### Dashboard File

The final dashboard is [Data_Jobs_Salary_Dashboard.xlsx](https://github.com/beverly-m/Data-Analytics-Projects/blob/801aa4eb9dc25eeacad28fc974ed44ad4260f0f6/1_Salary_Dashboard/Data_Jobs_Salary_Dashboard.xlsx)

### Dataset

The dataset contains 30,000+ real-world data job postings from 2023. The dataset is available via an [Excel for Data Analytics course by Luke Barousse](https://youtu.be/pCJ15nGFgVg?si=qicwLVMJyS4ycjqH).

It includes detailed information on job titles, salaries, locations, skills and posting platforms.

### Tools & Skills

I used the following Excel skills to build the dashboard

- ✅ Data Validation
- 🔢 Formulas & Functions
- 📈 Charts

## Building the Dashboard

### Filtering by job title, country and schedule

#### ✅ Data Validation - Filtered Lists

Filtered dropdown lists used to select the desired `job title`, `job country` and `job type`

- **prevent input errors** by restricting values that can be entered to validated inputs
- **improve dashboard usability** by providing a quick and simplified selection process

_Screen recording of lists_

### Median Salaries of Data Jobs

#### 📈 Horizontal Bar Charts - Job Title & Job Type

Horizontal bar charts provide a visual comparison of median salaries across the different job titles and job types. The data is sorted in ascending order and has formatted salary values to improve readability. The selected job title or job type is higlighted with a darker color for easier identification.

_Job title Bar chart image_

> 👆🏽 **User Input** - `job_title`: Data Analyst; `job_country`: United States; `job_schedule_type`: Full-Time
>
> 💡**Insights** - Data professionals with senior roles have a higher median salary than normal roles. Engineers and scientists earn more than analysts.
>
> 🤔 **Recommendations** - Job seekers aiming to maximize earning potential should prioritize advancing into senior roles and consider career paths in engineering or data science rather than analyst positions. Building specialized technical expertise and leadership skills can accelerate progression into these higher‑paying categories. Employers, meanwhile, should recognize the salary gap and ensure competitive compensation for analysts to retain talent and maintain balanced teams.

_Job type Bar chart image_

> 👆🏽 **User Input** - `job_title`: Data Analyst; `job_country`: United States; `job_schedule_type`: Full-Time
>
> 💡**Insights** - Data professionals with senior roles have a higher median salary than normal roles. Engineers and scientists earn more than analysts.
>
> 🤔 **Recommendations** - Job seekers aiming to maximize earning potential should prioritize advancing into senior roles and consider career paths in engineering or data science rather than analyst positions. Building specialized technical expertise and leadership skills can accelerate progression into these higher‑paying categories. Employers, meanwhile, should recognize the salary gap and ensure competitive compensation for analysts to retain talent and maintain balanced teams.

#### 📈 Map Chart - Job Country

I used a map chart to plot median salaries globally, with a color-coded design choice that visually differentiates salary levels across regions. This data representation helps users understand geographic salary trends and easily spot high and low paying regions.

_Map chart image_

#### 🔢 Formula - Median Salary by Job Title, Country & Schedule Type

```Excel formula syntax
MEDIAN(
  IF(
    (jobs[job_title_short] = A2) *
    (jobs[salary_year_avg] <> 0) *
    (jobs[job_country] = job_country) *
    (ISNUMBER(SEARCH(job_type,jobs[job_schedule_type]))),
    jobs[salary_year_avg]
    )
  )
```

This formula calculates the median salary for a specific `job_title`, `job_country`, and `job_schedule_type` while excluding missing or invalid salary values. Using the median ensures that extreme outliers don’t distort the results, giving job seekers a realistic benchmark for compensation.

### Top Platforms & Posting Volume

> #### Key Insights & Recommendations

#### 🔢 Formula: Job Count by Job Title, Country & Schedule Type

```Excel formula syntax
COUNT(
  IF(
     (jobs[job_country]=job_country) *
     (jobs[job_title_short]=A2) *
     (ISNUMBER(SEARCH(job_type,jobs[job_schedule_type]))),
     jobs[salary_year_avg]
    )
 )
```

This formula counts the number of jobs that meet the specified criteria `job_title`, `job_country`, and `job_schedule_type`, which helps job seekers understand data jobs that are in demand.

#### 🔢 Formula: Top Job Platform

```Excel formula syntax
COUNTIFS(jobs[job_via], A2,
         jobs[job_title_short], job_title,
         jobs[job_country], job_country,
         jobs[job_schedule_type], job_type)
```

This formula counts the number of job postings from a specific platform `job_via` based on the `job_title`, `job_country`, and `job_schedule_type` selected by the user. This helps job seekers identify which platforms are most effective for finding desired job roles.

## Conclusion
