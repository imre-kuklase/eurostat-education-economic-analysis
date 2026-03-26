/*
  TABEL: prod_fact_finance
  KIRJELDUS: Hariduse rahastamise kulud miljonites eurodes.
  ALLIKAS: stg_finance
  FILTER: 2012-2022, kõrgharidus, avalik ja era, sünkroniseeritud teiste faktitabelitega.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_finance` AS
SELECT 
  country_code,         -- FK: prod_dim_country
  sector_code,          -- FK: prod_dim_sector
  isced_level,          -- FK: prod_dim_isced
  year,                 -- FK: prod_dim_date
  expenditure_amount,   -- Mõõdik: kulu miljonites eurodes
  flag_code             -- Mõõdik: kande märge
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_finance`
WHERE year BETWEEN 2012 AND 2022
  AND expenditure_amount > 0
  AND sector_code IN ('S13', 'S1D')
  AND isced_level = 'ED5-8';
  AND country_code NOT LIKE 'EA%' -- Välistame summaarse Euro ala
  AND country_code NOT LIKE 'EU%' -- Välistame summaarse Euroopa Liidu
  AND country_code NOT IN ('AL','GE','XK','LI','ME','MK','UK',UA)
