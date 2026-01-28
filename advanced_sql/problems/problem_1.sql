SELECT 
    job_schedule_type AS job_type,
    AVG(salary_year_avg) AS avg_yearly_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) > 5
GROUP BY job_schedule_type
ORDER BY avg_yearly_salary DESC;
