/*
  TABEL: prod_dim_date
  KIRJELDUS: Ühtne ajatelg perioodiks 2013-2022.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_date` AS
SELECT 
  year,
  CASE 
    WHEN year <= 2015 THEN '2013-2017'
    WHEN year <= 2020 THEN '2017-2020'
    ELSE '2021-2022'
  END AS year_period
FROM UNNEST(GENERATE_ARRAY(2013, 2022)) AS year
ORDER BY
  year;
