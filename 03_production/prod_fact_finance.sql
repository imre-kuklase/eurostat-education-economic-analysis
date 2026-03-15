CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_finance` AS
SELECT country_code, sector_code, isced_level, year, expenditure_amount
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_finance`
WHERE expenditure_amount > 0;
