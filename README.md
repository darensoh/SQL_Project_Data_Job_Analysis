# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/).


# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.


### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?


# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.


# Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs and jobs in Singapore. This query highlights the high paying opportunities in the field.

#### Remote

```sql
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_location = 'Anywhere' AND -- meaning remote jobs
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here is the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

#### Singapore


```sql
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_location = 'Singapore' AND 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here is the breakdown of the top data analyst jobs in Singapore in 2023:

- **Consistent Salary Range:** The top-paying data analyst roles in Singapore offer salaries between $105,000 and $149,653, demonstrating a relatively consistent and competitive salary range in the field.
- **Notable Employers:** Companies like Bosch Group, FiscalNote, 2K, and ADDX are prominent employers, indicating a strong demand for data analysts across different sectors, including technology, finance, and environmental solutions.
- **Job Role Consistency:** Most roles are titled "Data Analyst," but there are specialized positions such as "Research Scientist - Energy System" and "Carbon Data Analyst," showing opportunities for niche expertise within the data analytics domain.

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

#### Remote
```sql
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_location = 'Anywhere' AND
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

#### Singapore

```sql
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_location = 'Singapore' AND
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in Singapore in 2023:
- **Python** is leading with a bold count of 10.
- **SQL** follows closely with a bold count of 8.
- **Spark** is also highly sought after, with a bold count of 6.
- **Tableau** appears frequently with a bold count of 5.
- **Excel** and **Power BI** both have a count of 3.
- Other skills like **R**, **AWS**, **Flow**, **Looker**, **Word**, **PowerPoint**, **Linux**, and **Hadoop** show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

#### Remote
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True 
    skills
ORDER BY demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023:
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

#### Singapore
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore'
GROUP BY 
    skills
ORDER BY demand_count DESC
LIMIT 5;
```

Here's the breakdown of the most demanded skills for data analysts in Singapore in 2023:

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python** and **Tableau** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support, with **R** replacing **Power BI** in Singapore's context.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 3635         |
| Python   | 3080         |
| Excel    | 2294         |
| Tableau  | 2199         |
| R        | 1315         |

*Table of the demand for the top 5 skills in data analyst job postings in Singapore*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
#### Remote
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies like PySpark ($208,172) and Couchbase ($160,515), machine learning tools like DataRobot ($155,486) and Jupyter ($152,777), and Python libraries Pandas ($151,821) and NumPy($143,513), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools like GitLab ($154,500), Kubernetes ($132,500) and Airflow ($126,103) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools such as Elasticsearch ($145,000), Databricks ($141,907) and GCP ($122,500) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

#### Singapore
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top-paying skills for Data Analysts in Singapore:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies like Spark ($121,027), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Proficiency in Data Tools and Languages:** Knowledge of various data analysis tools and programming languages such as Python ($103,713), R ($94,676), Tableau ($95,088), and SQL ($87,644) highlights the importance of technical expertise in handling, analyzing, and visualizing data.
- **Versatility with Productivity Software:** Proficiency in common productivity tools such as Excel ($100,569), Word ($105,838), and PowerPoint ($105,838) remains valuable, indicating the need for strong foundational skills in data presentation and documentation.
- **Cloud Computing and Advanced Analytics:** Familiarity with cloud services and advanced analytics tools like AWS ($92,435) and Azure ($72,750) suggests that cloud proficiency significantly boosts earning potential in data analytics, reflecting the growing importance of cloud-based analytics environments.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development. 
#### Remote
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = True AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.


#### Singapore
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore' AND 
    -- job_work_from_home = True AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 1
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```


| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 92       | spark      | 5            |           121,027 |
| 196      | powerpoint | 2            |           105,838 |
| 188      | word       | 2            |           105,838 |
| 215      | flow       | 3            |           105,558 |
| 1        | python     | 12           |           103,713 |
| 181      | excel      | 8            |           100,569 |
| 199      | spss       | 2            |            99,500 |
| 182      | tableau    | 8            |            95,088 |
| 5        | r          | 6            |            94,676 |
| 76       | aws        | 5            |            92,435 |

*Table of the most optimal skills for data analyst in Singapore sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in Singapore in 2023: 

- **High-Demand Programming Languages:** Python leads with the highest demand count of 12 and an average salary of $103,713. This reflects Python's strong value in data analysis and its widespread use in the industry. R follows with a demand count of 6 and an average salary of $94,676, indicating its importance for statistical analysis.

- **Specialized Data Processing Tools:** Spark shows a high demand count of 5 with an impressive average salary of $121,027, underscoring its role in big data processing and analytics. Flow also has a notable demand count of 3 and an average salary of $105,558, highlighting its relevance in workflow automation.

- **Business Intelligence and Visualization Tools:** Tableau and PowerPoint *(surprisingly)* are highly sought after, with demand counts of 8 and 2 respectively. Tableau's average salary of $95,088 signifies its role in data visualization and business intelligence, while PowerPoint's average salary of $105,838 reflects its utility in data presentation.

- **Core Data Management Tools:** Excel and SPS have substantial demand counts of 8 and 2 respectively. Excel's average salary is $100,569, reflecting its critical role in data manipulation and reporting, while SPSS's average salary is $99,500, showing its significance in statistical analysis.

- **Cloud and Infrastructure Tools:** AWS has a demand count of 5 and an average salary of $92,435, indicating the growing importance of cloud computing skills in data analytics and infrastructure management.

# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.


# Conclusions
### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market, both remotely and within Singapore. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.