/*
Question: What are the skills required for top-paying Business and Data Analyst jobs?
- Use the top 10 highest paying jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop to be aligned with top salaried jobs
*/

-- Top paying Business Analyst roles available remotely.
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
        job_title_short = 'Business Analyst' AND 
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

/*
Here is the breakdown of the skills:

SQL: 10
Python: 8
Excel: 5
Tableau: 5
Looker: 3
Chef: 1
R: 3
BigQuery: 1
GCP: 1
Word: 1
Sheets: 1
SAS: 2
Phoenix: 1

SQL is leading with a full count of 10.
Python follows closely with a count of 8.
Excel and Tableau are tied at 5. 
Other skills show varying degress of demand. 

[
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "sql"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "python"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "excel"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "tableau"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "looker"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "salary_year_avg": "220000.0",
    "company_name": "Noom",
    "skills": "chef"
  },
  {
    "job_id": 112859,
    "job_title": "Manager II, Applied Science - Marketplace Dynamics",
    "salary_year_avg": "214500.0",
    "company_name": "Uber",
    "skills": "python"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "salary_year_avg": "190000.0",
    "company_name": "Harnham",
    "skills": "sql"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "salary_year_avg": "190000.0",
    "company_name": "Harnham",
    "skills": "python"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "salary_year_avg": "190000.0",
    "company_name": "Harnham",
    "skills": "r"
  },
  {
    "job_id": 416185,
    "job_title": "Staff Revenue Operations Analyst",
    "salary_year_avg": "170500.0",
    "company_name": "Gladly",
    "skills": "excel"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "sql"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "python"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "bigquery"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "gcp"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "looker"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "word"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "salary_year_avg": "162500.0",
    "company_name": "CyberCoders",
    "skills": "sheets"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "salary_year_avg": "145000.0",
    "company_name": "CyberCoders",
    "skills": "sql"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "salary_year_avg": "145000.0",
    "company_name": "CyberCoders",
    "skills": "excel"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "salary_year_avg": "145000.0",
    "company_name": "CyberCoders",
    "skills": "tableau"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "sql"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "python"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "r"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "sas"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "phoenix"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "excel"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "tableau"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "salary_year_avg": "138640.0",
    "company_name": "USAA",
    "skills": "sas"
  },
  {
    "job_id": 661103,
    "job_title": "Marketing Analytics Manager",
    "salary_year_avg": "134550.0",
    "company_name": "Get It Recruit - Marketing",
    "skills": "tableau"
  }
]


