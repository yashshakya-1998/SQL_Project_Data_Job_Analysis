SELECT job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg IS NULL then 'Not Applicable'
        WHEN salary_year_avg < 100000 then 'Low salary'
        WHEN salary_year_avg BETWEEN 100000 AND 120000 then 'Standard salary'
        ELSE 'High salary'
    END as salary_bucket
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
Order BY salary_year_avg DESC NULLS LAST;
