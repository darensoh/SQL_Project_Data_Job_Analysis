/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries in Singapore
- Why? It reveals how different skills impact salary levels for Data Analysts and 
helps identify the most financially rewarding skills to acquire/improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND -- Using Data Analyst as the salaries for Business Analyst is insufficient and inaccurate
    -- job_work_from_home = True -- for remote jobs/work from home
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;

/* 
Breakdown of the results for top paying skills:

- High-Paying Skills in Data and Technology:
The top-paying skills are predominantly in data and technology, with "spark" leading 
at an average salary of $121,027. Other high-paying skills include "looker," 
"linux," "python," and "aws." These skills are essential for data analysis, 
data engineering, and software development, 
reflecting the high demand for expertise in these areas.

- Versatility of Productivity Tools:
Skills in common productivity tools like "word," "powerpoint," "excel," and "outlook"
also show significant salary values, with "word" and "powerpoint" both averaging 
$105,838. This indicates that proficiency in widely-used office applications 
remains valuable across various roles and industries, emphasizing the importance 
of versatility and adaptability.

- Emerging Importance of Cloud and Data Platforms:
Cloud-related skills such as "aws," "azure," and "gcp" are notable, with "aws" 
averaging $92,435 and "azure" and "gcp" at $72,750. Additionally, skills in data 
platforms like "qlik," "tableau," and "power bi" highlight the growing importance 
of data visualization and business intelligence tools in driving decision-making 
processes within organizations.

[
  {
    "skills": "spark",
    "avg_salary": "121027"
  },
  {
    "skills": "looker",
    "avg_salary": "111175"
  },
  {
    "skills": "linux",
    "avg_salary": "109500"
  },
  {
    "skills": "word",
    "avg_salary": "105838"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "105838"
  },
  {
    "skills": "flow",
    "avg_salary": "105558"
  },
  {
    "skills": "python",
    "avg_salary": "103713"
  },
  {
    "skills": "excel",
    "avg_salary": "100569"
  },
  {
    "skills": "qlik",
    "avg_salary": "100500"
  },
  {
    "skills": "zoom",
    "avg_salary": "100500"
  },
  {
    "skills": "numpy",
    "avg_salary": "100500"
  },
  {
    "skills": "slack",
    "avg_salary": "100500"
  },
  {
    "skills": "pandas",
    "avg_salary": "100500"
  },
  {
    "skills": "sas",
    "avg_salary": "100500"
  },
  {
    "skills": "spss",
    "avg_salary": "99500"
  },
  {
    "skills": "javascript",
    "avg_salary": "98500"
  },
  {
    "skills": "tableau",
    "avg_salary": "95088"
  },
  {
    "skills": "r",
    "avg_salary": "94676"
  },
  {
    "skills": "aws",
    "avg_salary": "92435"
  },
  {
    "skills": "sql",
    "avg_salary": "87644"
  },
  {
    "skills": "power bi",
    "avg_salary": "87058"
  },
  {
    "skills": "hadoop",
    "avg_salary": "84338"
  },
  {
    "skills": "outlook",
    "avg_salary": "79200"
  },
  {
    "skills": "azure",
    "avg_salary": "72750"
  },
  {
    "skills": "gcp",
    "avg_salary": "72750"
  }
]
*/