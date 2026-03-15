-- Sugu dimensioon
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_sex` AS
SELECT 'T' AS sex_code, 'Kokku' AS sex_name_et, 'Total' AS sex_name_en UNION ALL
SELECT 'M', 'Mehed', 'Males' UNION ALL
SELECT 'F', 'Naised', 'Females';
