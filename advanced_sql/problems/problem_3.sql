SELECT 
    company_dim.name as name,
    COUNT (job_postings_fact.job_id) as count
FROM 
    job_postings_fact
INNER JOIN 
    company_dim
    ON 
        job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.job_health_insurance = TRUE 
    AND
    (EXTRACT (MONTH FROM job_postings_fact.job_posted_date) BETWEEN 4 AND 6)
GROUP BY name
ORDER BY count DESC;