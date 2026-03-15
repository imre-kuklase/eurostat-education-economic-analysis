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
WHERE student_count IS NOT NULL
  AND sex_code != 'T' -- 1. Eemaldame soo koondsummad (jäävad M ja F)
  AND worktime_code NOT IN ('Total', 'TOT_FTE') -- 2. Eemaldame töökoormuse koondsummad (jäävad FT ja PT)
  AND sector_code NOT IN ('TOT_SEC', 'PRV_IND') -- 3. Eemaldame sektorite koondsummad (jäävad PUB, PRV jne)
  AND isced_level IN ('ED5', 'ED6', 'ED7', 'ED8') -- 4. Eemaldame haridustasemete koondsummad (jäävad ED5, ED6, ED7, ED8)
  AND unit_code = 'NR'; -- 5. Veendume, et ühik on arvuline (Number)
