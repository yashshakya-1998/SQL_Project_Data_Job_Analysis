-- ////////Union problem from that 1st sql problem
-- Get jobs for Data analyst(salary>100k) and Business Analyst(salary>80k)
-- job location - Boston, MA or Anywhere(remote)
-- for only 1st three months jan, feb, mar

SELECT
    job_id,
    job_title_short,
    salary_year_avg
FROM jan_2023_jobs
WHERE ((job_title_short = 'Data Analyst' and salary_year_avg > 100000)
    OR
    (job_title_short = 'Business Analyst' AND salary_year_avg > 70000))
    AND (job_location in ('Boston, MA','Anywhere'))

UNION all

SELECT
    job_id,
    job_title_short,
    salary_year_avg
FROM feb_2023_jobs
WHERE ((job_title_short = 'Data Analyst' and salary_year_avg > 100000)
    OR
    (job_title_short = 'Business Analyst' AND salary_year_avg > 70000))
    AND (job_location in ('Boston, MA','Anywhere'))

UNION all

SELECT
    job_id,
    job_title_short,
    salary_year_avg
FROM mar_2023_jobs
WHERE ((job_title_short = 'Data Analyst' and salary_year_avg > 100000)
    OR
    (job_title_short = 'Business Analyst' AND salary_year_avg > 70000))
    AND (job_location in ('Boston, MA','Anywhere'))


--///////////////// MORE CLEANER VERSION//////////////// BUT LESS ACCURATE



With quarter_1_jobs as(
    SELECT job_id, job_title_short, salary_year_avg, job_location FROM jan_2023_jobs
    UNION all
    SELECT job_id, job_title_short, salary_year_avg, job_location FROM jan_2023_jobs
    UNION all
    SELECT job_id, job_title_short, salary_year_avg, job_location FROM jan_2023_jobs
)
SELECT 
    job_id,
    job_title_short,
    salary_year_avg
FROM quarter_1_jobs
WHERE ((job_title_short = 'Data Analyst' and salary_year_avg > 100000)
    OR
    (job_title_short = 'Business Analyst' AND salary_year_avg > 70000))
    AND (job_location in ('Boston, MA','Anywhere')); 

-- ////////////////Another method/////////////////////// ACCURATE
SELECT
    quarter_1_jobs.job_title_short,
    quarter_1_jobs.job_location,
    quarter_1_jobs.job_posted_date::Date,
    quarter_1_jobs.salary_year_avg
From(
    SELECT * from jan_2023_jobs
    UNION all
    SELECT * from feb_2023_jobs
    UNION all
    SELECT * from mar_2023_jobs
) as quarter_1_jobs
WHERE ((job_title_short = 'Data Analyst' and salary_year_avg > 100000)
    OR
    (job_title_short = 'Business Analyst' AND salary_year_avg > 70000))
    AND (job_location in ('Boston, MA','Anywhere'))
ORDER BY salary_year_avg;

-- ///////////////////////////////////////////////////////

-- Problem 8
-- Get job postings for 1st quarter
-- job title, salary, location, date

-- ////////////////////////////////////////////////////////

SELECT
    quarter_1_jobs.job_title_short,
    quarter_1_jobs.job_location,
    quarter_1_jobs.job_via,
    quarter_1_jobs.job_posted_date::Date,
    quarter_1_jobs.salary_year_avg
From(
    SELECT * from jan_2023_jobs
    UNION all
    SELECT * from feb_2023_jobs
    UNION all
    SELECT * from mar_2023_jobs
) as quarter_1_jobs
WHERE quarter_1_jobs.salary_year_avg > 70000 and quarter_1_jobs.job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;