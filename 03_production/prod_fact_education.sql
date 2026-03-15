/*
  TABEL: prod_fact_education
  KIRJELDUS: Üliõpilaste arv kõrghariduses.
  ALLIKAS: stg_high_education
  FILTER: 2012-2024, ainult positiivsed väärtused.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_education` AS
SELECT 
  country_code, -- FK: prod_dim_country
  sector_code,  -- FK: prod_dim_sector
  isced_level,  -- FK: prod_dim_isced
  year,         -- FK: prod_dim_date
  student_count -- Mõõdik: õppurite arv
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education`
WHERE year BETWEEN 2012 AND 2022
  AND student_count > 0;
