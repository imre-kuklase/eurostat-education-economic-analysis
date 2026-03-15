CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_date` AS
SELECT 
  year
FROM UNNEST(GENERATE_ARRAY(2005, 2025)) AS year;
