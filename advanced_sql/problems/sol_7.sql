-- //////////////////////Wrong solution///////////////
-- WITH job_count as (
--     SELECT
--         job_id,
--         skill_id,
--         COUNT(job_id) as remote_job_count
--     FROM skills_job_dim
--     GROUP BY skill_id
--     LIMIT 10
--     )
-- SELECT 
--     skills_dim.skill_id,
--     skills_dim.skills,
--     job_count.remote_job_count
-- FROM skills_dim
-- INNER JOIN job_count
--     ON job_count.skill_id = skills_dim.skill_id
-- INNER JOIN (
--     SELECT
--         job_id
--     FROM job_postings_fact
--     WHERE job_work_from_home = TRUE
-- ) as remote_jobs
--     ON remote_jobs.job_id = job_count.job_id
-- ///////////////////////////////////////////////////////////

-- You need to:
-- Count remote job postings per skill
-- Use only remote jobs (job_work_from_home = TRUE)

-- Return:
-- skill_id
-- skill name
-- count of remote job postings
-- Show top 5 skills by demand

-- Key idea:
-- Filter to remote jobs FIRST, then count skills


-- SELECT job_id, skill_id, COUNT(job_id)
-- FROM skills_job_dim
-- GROUP BY skill_id
-- 🚫 This is invalid logic:
-- You cannot select job_id unless it’s grouped or aggregated
-- Also: grouping by skill_id while selecting job_id breaks the grain

-- You counted jobs BEFORE filtering remote jobs

-- -- Overcomplicated joins
-- You don’t need:
-- job_id in the final result
-- a separate remote jobs subquery

-- ////////////////////////////////////
-- Correct order of operations:
-- _____________________________
-- >> Filter remote jobs
-- >> Join to skills_job_dim
-- >> Count jobs per skill
-- >> Join to skills_dim
-- >> Order + limit


WITH remote_jobs as(
    SELECT
        job_id
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
),
    job_count as(
        SELECT 
            skills_job_dim.skill_id,
            count(remote_jobs.job_id) as remote_job_count
        FROM skills_job_dim
        INNER JOIN remote_jobs
            ON remote_jobs.job_id = skills_job_dim.job_id
        GROUP BY skills_job_dim.skill_id
)
select skills_dim.skill_id,
    skills_dim.skills,
    job_count.remote_job_count
FROM job_count
INNER JOIN skills_dim
    ON skills_dim.skill_id = job_count.skill_id
ORDER BY job_count.remote_job_count DESC
LIMIT 5;



-- ////////////////////////////////////////////////
-- different approach

WITH remote_jobs_count as (
        SELECT
            skill_id,
            count(job_postings_fact.job_id) as remote_job_skill_count
        FROM skills_job_dim
        INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE job_postings_fact.job_work_from_home = TRUE
        AND job_postings_fact.job_title_short = 'Data Analyst'
        GROUP BY skill_id
)
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    remote_jobs_count.remote_job_skill_count
FROM remote_jobs_count
INNER JOIN skills_dim ON skills_dim.skill_id = remote_jobs_count.skill_id
ORDER BY remote_job_skill_count DESC
LIMIT 5;
