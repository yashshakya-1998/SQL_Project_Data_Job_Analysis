-- Question: What are the top-paying Data Analyst jobs?
-- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-- Focus only on job postings with specified salaries (exclude null salary values).
-- Why? This highlights the top-paying opportunities for Data Analysts and provides insight into employment trends for high-compensation roles.

SELECT
    job_id,
    job_title_short,
    job_location,
    job_posted_date,
    salary_year_avg,
    name as company_name
FROM job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg is NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
