SELECT 
    COUNT(job_id) as count_of_jobs,
    EXTRACT(MONTH FROM job_posted_date at time zone 'UTC' at time zone 'EST') as job_month
FROM job_postings_fact
GROUP BY job_month
ORDER BY job_month;