
---SUBQUERY
SELECT 
    company_id,
    name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = TRUE
        ORDER BY company_id
)


-----by inner Join
SELECT DISTINCT
    company_dim.company_id,
    company_dim.name as company_name
FROM company_dim
Inner Join job_postings_fact
    ON
         company_dim.company_id = job_postings_fact.company_id
WHERE
    job_postings_fact.job_no_degree_mention = TRUE
ORDER BY company_id