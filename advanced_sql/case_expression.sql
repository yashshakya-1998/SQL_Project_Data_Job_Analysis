SELECT 
    count(job_id) as job_count,
    CASE 
        WHEN job_location = 'Anywhere' then 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END as job_sub_location
FROM job_postings_fact
where job_title_short = 'Data Analyst'
GROUP BY job_sub_location;