SELECT 
    count(job_id) as job_count,
    EXTRACT (MONTH FROM job_posted_date) as date_month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY date_month
ORDER BY date_month;