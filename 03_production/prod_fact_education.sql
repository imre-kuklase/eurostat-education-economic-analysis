/*
  SKRIPT: prod_fact_education.sql
  EESMÄRK: Lõplik faktitabel Power BI jaoks.
  MUUDATUSED: Lisatud sex, worktime ja unit koodid filtreerimiseks.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_education` AS
SELECT 
    country_code,
    sector_code,
    isced_level,
    year,
    sex_code,     
    worktime_code,  
    unit_code,      
    student_count
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education`
WHERE student_count IS NOT NULL;
