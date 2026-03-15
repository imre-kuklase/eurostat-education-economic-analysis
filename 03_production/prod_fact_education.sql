CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_education` AS
SELECT country_code, sector_code, isced_level, year, student_count
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education`
WHERE student_count > 0;
