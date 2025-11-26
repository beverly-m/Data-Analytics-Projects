# Data Jobs Salary Dashboard

![Salary Dashoboard-speed](https://github.com/user-attachments/assets/31c673ad-ad6a-46a8-9a4f-f8391aac0ab9)

## Introduction

### Problem

Job seekers often face uncertainty when evaluating compensation offers, as salary information can be fragmented, outdated, or inconsistent across sources. Without clear insights into market pay ranges, individuals risk accepting positions with inadequate compensation relative to their skills, experience, and industry standards.

To address this challenge, I developed a job salary dashboard to visualise salary data, enabling job seekers to investigate pay trends for specific roles and make informed decisions about their career opportunities.

### Objective

To analyse salary trends in data‑related jobs by examining how compensation varies across different geographic locations and employment schedules (e.g., full‑time or part-time). The goal is to provide clear, actionable insights that help job seekers evaluate fair pay.

### Dashboard File

The final dashboard is [Data_Jobs_Salary_Dashboard.xlsx](https://github.com/beverly-m/Data-Analytics-Projects/blob/801aa4eb9dc25eeacad28fc974ed44ad4260f0f6/1_Salary_Dashboard/Data_Jobs_Salary_Dashboard.xlsx)

### Dataset

The dataset comprises over 30,000 real-world job postings from 2023. The dataset is available via an [Excel for Data Analytics course by Luke Barousse](https://youtu.be/pCJ15nGFgVg?si=qicwLVMJyS4ycjqH).

It includes detailed information on job titles, salaries, locations, skills and posting platforms.

### Tools & Skills

I used the following Excel skills to build the dashboard

- ✅ Data Validation
- 🔢 Formulas & Functions
- 📈 Charts

## Building the Dashboard

### Filtering by job title, country and schedule

#### ✅ Data Validation - Filtered Lists

Filtered dropdown lists used to select the desired `job title`, `job country` and `job type`:

- **prevent input errors** by restricting values that can be entered to validated inputs
- **improve dashboard usability** by providing a quick and simplified selection process

![FilteredList-loop-count](https://github.com/user-attachments/assets/d1e96fd1-6070-4539-a52d-6d57d2c88bfd)

### Median Salaries of Data Jobs

#### 📈 Horizontal Bar Charts - Job Title & Job Type

Horizontal bar charts provide a visual comparison of median salaries across the different job titles and job types. The data is in ascending order and has formatted salary values to improve readability. The selected job title or job type is highlighted with a darker colour for easier identification.

<img width="400" alt="Bar chart visualising median salary by job title" src="https://github.com/user-attachments/assets/dc329938-4260-45bf-92b2-91e8f2cfc2f9" />

> 👆🏽 **User Input** - `job_title`: Data Analyst ~ `country`: United States ~ `job_schedule_type`: Full-Time
>
> 💡**Insights** - Data professionals with senior roles have a higher median salary than normal roles. Engineers and scientists earn more than analysts.
>
> 🤔 **Recommendations** - Job seekers aiming to maximise earning potential should prioritise advancing into senior roles and consider career paths in engineering or data science rather than analyst positions. Building specialised technical expertise and leadership skills can accelerate progression into these higher‑paying categories.

<img width="400" alt="Bar chart visualising median salary by job schedule type" src="https://github.com/user-attachments/assets/7edbfce3-0339-4b3c-80dd-0c46de379fc5" />

> 👆🏽 **User Input** - `job_title`: Data Engineer ~ `job_country`: United States ~ `job_schedule_type`: Full-Time
>
> 💡**Insights** - Data engineers earn more in temporary and part-time schedules than in full-time and contractor roles, with interns earning the least.
>
> 🤔 **Recommendations** - Job seekers pursuing data engineering roles should consider temporary or part‑time opportunities as potential pathways to higher compensation, especially when flexibility aligns with their career goals.

#### 📈 Map Chart - Job Country

I used a map chart to plot median salaries globally, with a colour-coded design choice that visually differentiates salary levels across regions. This data representation helps users understand geographic salary trends and easily spot high and low-paying regions.

![Map Chart-speed](https://github.com/user-attachments/assets/79b6ba85-b8ef-4770-bc14-10658642bf68)

> 👆🏽 **User Input** - `job_title`: Data Scientist ~ `job_schedule_type`: Full-Time
> 
> 💡**Insights** - The map visualisation reveals that median salaries for data scientist roles generally range between USD 80k and USD 130k worldwide, with neighbouring countries often displaying similar compensation levels. Australasia, North America, and Northern Europe stand out as regions offering comparatively higher salaries, reflecting strong demand and mature data industries. Notably, Russia presents an outlier with a median salary of USD 250k.
>
> 🤔 **Recommendations** - Job seekers in data science should consider targeting opportunities in regions such as Australasia, North America, and Northern Europe, where median salaries are consistently higher. They should also use regional salary benchmarks to negotiate fair compensation, especially when relocating or working remotely. It is important to keep note of outliers - unusually high median salaries - and verify whether such figures reflect sustainable market trends or niche circumstances.

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

![Job Count-speed](https://github.com/user-attachments/assets/f4f8729a-4ec5-48a6-a517-ea5c9db1e5c5)

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

This analysis highlights how compensation in data roles varies significantly by job title, seniority, schedule, and location. For job seekers, these insights emphasise the importance of considering not only the role itself but also the employment schedule and location when evaluating opportunities. By leveraging this dashboard, individuals can benchmark fair compensation, identify high‑paying regions and roles, and make more informed career decisions that align with both financial goals and professional growth.
