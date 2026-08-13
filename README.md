# Welcome to my dbt first project - tutorial

# Learning source
- dbt Tutorial (Data Build Tool) Hands-on-courese - Youtube from SleekData
- https://github.com/MarkPhamm/dbt-Fundamental for reading, summary and reference
I recommend you should watch tutorial and read MarkPhamm's github at the same time

# Commands that I learned during the project 
### Note: For more details, check MarkPhamm's github, he already helps us to summarize all of the neccessary thing.
- dbt init: for BigQuery dbt project intialization, when we input for project -it should be our project-id that has already existed on cloud and we also use need to authorize ourself with following command gcloud auth application-default login when we choose oath method to use ADC.
- dbt debug: checking is everything ok after dbt init
- dbt run: Because one of the strength of dbt is that we do not need to deal with DDL/DML statement, we need to have this command to help us deal with that problem. You can think like we go to buffet restaurant and use DQL to choose data (raw food), then dbt run will help us to DDL and DML into edible food (table or view). So our job is choosing we wanted data and how should data be cooked, other part just give to dbt run. 
- {{ ref('old model') }} to reuse old model. We do not need to specify the specific path if
.sql file is in subfolder of models (like staging or mart). dbt helps us to scan the whole models folder. Therefore, when naming, we should gives each models a uniqe name.

# Entity relationship diagram in my project 
![Entity relationship diagram](ERD.png)

# Concept
## Note
- Two yml files that we need to understand and interact with most of the time: profiles.yml ( in Ubuntu its path is ~/.dbt/profiles.yml) and dbt_project.yml ( right in our dbt project ) 
## Materialization: {{ config(materialized='__') }}
- View: 
    + Store only SQL definition, no real data on disk. 
    + Run every time the view is queried
    + Building time is fast, but slow for downstream query if data is large or query is complex.
    + Incurs compute costs every time someone queries the view.
    + Always show latest live data in the source table. 
- Table:
    + Store actual computed data on physical disk.
    + Run only once during the dbt run and store result to storage.
    + Building time is slow becase it need to really compute and write data to disk, but fast for downstream query
    + Incurs compute costs during dbt run but downstream queries only scan the pre-built table.
    + Cannot update latest data. We need to regularly dbt run.
- Incremental - like table but have some difference:
    + Appends or updates only new/changed records since the last run while table builds everything again per run.
    + Build time is faster than table.
    + Lower warehouse cost because it scans significantly fewer rows per run.
    + Requires defining an is_incremental() macro filter and a unique key to handle updates.
    + Requires configuration to prevent duplicate records.
## Modularity
- Breaking donw large models into multiple smaller models.
- Better for readability, reuseability, maintainanbility, scalability, testability. 
![Modularity example](modularity_example.png)
## Naming convention
- Source (src): refer to raw table data in DW which is the result of loading process.
- Staging (stg): tables that are built directly from source with one to one relationship. Have very light transformation (kind of formatting and cleaning). These are typically materialized as view
- Intermediate (int) any table or data that exists between stg and final fact/dim table.
- Fact: a table that describes an event (session, transaction, orders,...).
- Dim: a table that describes an object (human, building, department,...).
## Schema
- A namespace or container inside our datawarehouse (different from our models folder in local machine) where dbt builds and stores your transformed tables and views.
- By default, dbt builds and stores all models in target schema (which we can find in profiles.yml). Or we can custom models' schema in dbt_project.yml (individually or collectively).
## Project Organization (on our local machine in models folder) - below is just my favor. You can change to follow your needs.
- Staging subfolder: stores all staging models
- Marts subfolder:  stores all intermediate models.
- Final subfolder: stores all consumption models (which end user can directly use).

# Reference Resources from dbt:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
# END