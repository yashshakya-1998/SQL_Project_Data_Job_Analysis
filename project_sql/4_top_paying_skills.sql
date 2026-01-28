/* What are the top paying skills for my role
-- Look at the avg salary for each skill associated with data analyst position
focuses n roles with specified salaries regardless of location
Why? It reveals how different skills impavct the salary as it helps identifying the most finacially rewarding skills
*/

SELECT skills,
    Round(Avg(job_postings_fact.salary_year_avg),0) as avg_yearly_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_yearly_salary DESC
LIMIT 25;

/*Here are concise, straight-to-the-point insights from the top 25 skills vs average yearly salary list:

--Highest-paying skills (PySpark, Bitbucket, Couchbase) are engineering- and infrastructure-heavy, not traditional analyst tools.

--Skills like PySpark, Databricks, Airflow, Kubernetes indicate that big data & data engineering overlap pays more.

--Python ecosystem skills (Pandas, NumPy, Jupyter, scikit-learn) still command strong salaries, showing analytics + ML capability is valued.

--DevOps & tooling skills (GitLab, Jenkins, Linux, Atlassian) boost pay, signaling demand for analysts who can work in production environments.

--Cloud & platform skills (GCP, Databricks) consistently sit above $120k, reinforcing cloud literacy as a salary driver.

--Classic analytics tools (PostgreSQL, MicroStrategy) pay well but less than hybrid/engineering skills.

Bottom line:
The highest salaries go to data analysts who blend analytics with engineering, automation, and cloud skills, not those limited to reporting or dashboards.



[
  {
    "skills": "pyspark",
    "avg_yearly_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_yearly_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_yearly_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_yearly_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_yearly_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_yearly_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_yearly_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_yearly_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_yearly_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_yearly_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_yearly_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_yearly_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_yearly_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_yearly_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_yearly_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_yearly_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_yearly_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_yearly_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_yearly_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_yearly_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_yearly_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_yearly_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_yearly_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_yearly_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_yearly_salary": "121619"
  }
]*/