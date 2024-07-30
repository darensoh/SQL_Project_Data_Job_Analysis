/*
Question: What are the most optimal skills to learn (aka it is high in demand + high-paying)
- Identify skills in high demand and associated with high average salaries
- Concentrates on remote positions with specified salaries
- Why? Target skills that offer job security and financial benefits, offering 
strategic insights for career development in data analysis.
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND -- using data analyst due to insufficient data for business analyst
        -- job_work_from_home = True -- for remote jobs/work from home
        job_location = 'Singapore' AND 
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id
) , average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        -- job_work_from_home = True -- for remote jobs/work from home
        job_location = 'Singapore' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
)
SELECT  
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 25;

--rewriting the same query more concisely
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
ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 25;