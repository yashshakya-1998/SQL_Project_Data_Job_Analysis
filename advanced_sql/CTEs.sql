----Get the total no jobs per company id and return the company naame an no jobs fot that company


-----chatgpt sol
WITH job_counts AS (
    SELECT
        company_id,
        COUNT(job_id) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
),
    company_jobs AS (
    SELECT
        name AS company_name,
        total_jobs
    FROM job_counts
    JOIN company_dim
        ON job_counts.company_id = company_dim.company_id
)
SELECT
    company_name,
    total_jobs
FROM company_jobs
ORDER BY total_jobs DESC;



---my sol
WITH company_job_count as(   
    SELECT company_id,
    COUNT(job_id) as total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT 
    company_dim.name as company_name,
    company_job_count.total_jobs
FROM company_dim
INNER JOIN company_job_count
    ON
        company_dim.company_id = company_job_count.company_id;
