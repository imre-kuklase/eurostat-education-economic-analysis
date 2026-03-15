-- Töökoormuse dimensioon
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_worktime` AS
SELECT 'Total' AS worktime_code, 'Kokku' AS worktime_name_et, 'Total' AS worktime_name_en UNION ALL
SELECT 'FT', 'Täiskoormus', 'Full-time' UNION ALL
SELECT 'PT', 'Osakoormus', 'Part-time';
