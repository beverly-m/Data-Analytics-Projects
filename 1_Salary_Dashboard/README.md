# Data Jobs Salary Dashboard

_Screen recording of dashboard_

## Introduction

### Problem

Job seekers often face uncertainty when evaluating compensation offers, as salary information can be fragmented, outdated, or inconsistent across sources. Without clear insights into market pay ranges, individuals risk accepting positions with inadequate compensation relative to their skills, experience, and industry standards.

To address this challenge, I developed a job salary dashboard to visualize salary data, enabling job seekers to investigate pay trends for specific roles and make informed decisions about their career opportunities.

### Objective

To investigate salary trends of data jobs considering their location and schedule (e.g. full-time, part-time or internship).

### Dashboard File

The final dashboard is [Data_Jobs_Salary_Dashboard.xlsx](https://github.com/beverly-m/Data-Analytics-Projects/blob/801aa4eb9dc25eeacad28fc974ed44ad4260f0f6/1_Salary_Dashboard/Data_Jobs_Salary_Dashboard.xlsx)

### Dataset

The dataset contains real-world data job information from 2023. The dataset is available via an [Excel for Data Analytics course by Luke Barousse](https://youtu.be/pCJ15nGFgVg?si=qicwLVMJyS4ycjqH).

It includes detailed information on job titles, salaries, locations, skills and posting platforms.

### Tools & Skills

I used the following Excel skills to build the dashboard

- ✅ Data Validation
- 🔢 Formulas & Functions
- 📈 Charts

## Building the Dashboard

### Filtering by job title, country and schedule

#### ✅ Data Validation: Filtered Lists

_Justification_

_Screen recording of lists_

### Calculating & Visualising Median Salary Trends

#### 🔢 Median Salary by Job Title

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

_Justification_

#### 📈 Bar Chart - Median Salaries of Data Jobs

_Justification_

_Bar chart image_

#### 🔢 Median Salary by Country

```Excel formula syntax
MEDIAN(
  IF(
     (jobs[job_country]=A2) *
     (jobs[salary_year_avg]<>0) *
     (jobs[job_title_short]=job_title) *
     (ISNUMBER(SEARCH(job_type,jobs[job_schedule_type]))),
     jobs[salary_year_avg]
    )
 )
```

_Justification_

#### 📈 Map Chart - Median Salaries of Countries

_Justification_

_Map chart image_

#### 🔢 Top Job Platform

```Excel formula syntax
COUNTIFS(jobs[job_via], A2,
         jobs[job_title_short], job_title,
         jobs[job_country], job_country,
         jobs[job_schedule_type], job_type)
```

_Justification_

#### 🔢 Median Salary of Job Schedules

```Excel formula syntax
MEDIAN(
  IF(
     (jobs[job_country]=job_country) *
     (jobs[salary_year_avg]<>0) *
     (jobs[job_title_short]=job_title) *
     (ISNUMBER(SEARCH(A2,jobs[job_schedule_type]))),
     jobs[salary_year_avg]
    )
 )
```

_Justification_

#### 📈 Bar Chart - Median Salaries of Job Schedules

_Justification_

_Bar chart image_

#### 🔢 Job Count

```Excel formula syntax
=COUNT(
  IF(
     (jobs[job_country]=job_country) *
     (jobs[job_title_short]=A2) *
     (ISNUMBER(SEARCH(job_type,jobs[job_schedule_type]))),
     jobs[salary_year_avg]
    )
 )
```

_Justification_

## Key Insights

## Recommendations
