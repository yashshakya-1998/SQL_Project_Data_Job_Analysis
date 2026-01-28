
-- Problem 1.
-- Identify the top 5 skills that are most frequently mentioned in job postings.
-- Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table, and then join this result with the skills_dim table to get the skill names.



-- Using CTEs and JOIN

WITH skills_job_count as(
    SELECT 
        skill_id,
        count (job_id) as skill_count
    FROM skills_job_dim
    group BY skill_id
)
SELECT skills_dim.skills as skills,
    skills_job_count.skill_count
FROM skills_dim
LEFT JOIN skills_job_count
    ON
        skills_job_count.skill_id = skills_dim.skill_id
Limit 5;


---Using SUBQUERY and JOIN---

SELECT
    skills_dim.skills AS skill_name,
    skill_counts.skill_count
FROM skills_dim
LEFT JOIN (
    SELECT
        skill_id,
        COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) AS skill_counts
    ON skill_counts.skill_id = skills_dim.skill_id
LIMIT 5;


-- Problem 2.

-- Determine the size category (Small, Medium, or Large) for each company by first identifying the number of job postings they have.

-- Use a subquery to calculate the total job postings per company.
-- Then classify companies based on the following rules:

-- A company is considered Small if it has less than 10 job postings

-- A company is considered Medium if it has between 10 and 50 job postings

-- A company is considered Large if it has more than 50 job postings

-- Implement the subquery to aggregate job counts per company before classifying them based on size.

-- Method 1. using CTEs and JOIN

WITH company_job_count AS( --CTE starts here
    SELECT 
        company_id,
        count(job_id) as job_count
    FROM job_postings_fact
    GROUP BY company_id
) -- CTE ends here
SELECT 
    company_dim.name as company_name,
    company_job_count.job_count,
    CASE 
        WHEN company_job_count.job_count IS NULL then 'Small scale company'
        WHEN company_job_count.job_count < 10 then 'Small scale company'
        WHEN company_job_count.job_count BETWEEN 10 and 50 THEN 'Medium scale company'
        Else 'Large scale company'
    END as company_category
FROM company_dim
LEFT JOIN 
    company_job_count
        ON
            company_job_count.company_id = company_dim.company_id;


-- Method 2. Using subquery and JOIN

SELECT 
    company_dim.name as company_name,
    company_job_count.job_count,
    CASE
        WHEN job_count is NULL THEN 'Small scale company'
        WHEN job_count < 10 then 'Small scale company'
        WHEN job_count BETWEEN 10 and 50 THEN 'Medium scale company'
        Else 'Large scale company'
    END as company_scale_category
FROM 
    company_dim
LEFT JOIN (
    SELECT
        company_id,
        count(job_id) as job_count
    FROM job_postings_fact
    GROUP BY company_id
    ) as company_job_count
    ON company_job_count.company_id = company_dim.company_id;



-- //////////////////Practicing above queries again ////////////////////////////--

WITH company_job_count as (
    SELECT
    company_id,
    count(job_id) as job_count
    FROM job_postings_fact
    GROUP BY company_id
    )
SELECT company_dim.name as company_name,
    company_job_count.job_count,
    CASE WHEN job_count is NULL then 'Small scale company'
    WHEN job_count < 10 THEN 'Small scale company'
    WHEN job_count BETWEEN 10 and 50 THEN 'Medium scale company'
    ELSE 'Large scale company'
    END as company_scale_bucket
FROM company_dim
INNER JOIN company_job_count
ON company_job_count.company_id = company_dim.company_id;



SELECT 
    company_dim.name as company_name,
    company_job_count.job_count,
    CASE 
        WHEN job_count is NULL then 'Small scale company'
        WHEN job_count < 10 THEN 'Small scale company'
        WHEN job_count BETWEEN 10 and 50 THEN 'Medium scale company'
        ELSE 'Large scale company'
    END as company_scale_bucket
FROM company_dim
INNER JOIN(
    SELECT
        company_id,
        count(job_id) as job_count
    FROM job_postings_fact
    group by company_id
) as company_job_count
on company_job_count.company_id = company_dim.company_id
ORDER BY job_count DESC
