
-- sample data
-- create or replace view pypi_metrics as from 's3://us-prd-motherduck-open-datasets/pypi/sample_tutorial/pypi_file_downloads/*/*/*.parquet';
-- select * from pypi_metrics limit 10;
-- select unnest(details) from pypi_metrics limit 10;
with pre_aggregated_data as (
  select
    timestamp::date as download_date,
    details.system.name as system_name,
    details.system.release as system_release,
    file.version as version,
    project,
    country_code,
    details.cpu as cpu,
    CASE
      WHEN details.python IS NULL THEN NULL
      ELSE CONCAT(
        SPLIT_PART(details.python, '.', 1),
        '.',
        SPLIT_PART(details.python, '.', 2)
      )
    END AS python_version
  -- from 's3://us-prd-motherduck-open-datasets/pypi/sample_tutorial/pypi_file_downloads/*/*/*.parquet'
  from {{ source('external_source', 'pypi_file_downloads') }}
)

SELECT
    MD5(CONCAT_WS('|', download_date, system_name, system_release, version, project, country_code, cpu, python_version)) AS load_id,
    download_date,
    system_name,
    system_release,
    version,
    project,
    country_code,
    cpu,
    python_version,
    COUNT(*) AS daily_download_sum
FROM
    pre_aggregated_data
GROUP BY
    ALL
