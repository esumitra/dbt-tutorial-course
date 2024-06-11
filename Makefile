include .env
export

DBT_FOLDER = transform/pypi_metrics
DBT_TARGET = dev

pypi-transform:
	cd $(DBT_FOLDER) && \
	dbt run \
	--target $(DBT_TARGET) \
	--vars '{"start_date": "$(START_DATE)", "end_date": "$(END_DATE)"}'

pypi-transform-test:
	cd $(DBT_FOLDER) && \
	dbt test \
	--target $(DBT_TARGET) \
	--vars '{"start_date": "$(START_DATE)", "end_date": "$(END_DATE)"}'