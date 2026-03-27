/*
  TABEL: prod_fact_gdp
  KIRJELDUS: Riikide SKP näitajad jooksvates hindades (Current Prices).
  ALLIKAS: stg_gdp
  AJARAAM: 2012-2022 (Sünkroniseeritud haridusandmetega)
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_gdp` AS
SELECT 
  country_code,
  year,
  unit AS unit_code,  
  na_item, 
  gdp_amount,
  flag_code
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_gdp`
WHERE 
  year BETWEEN 2013 AND 2022 
  AND unit = 'CP_MEUR' -- Kasutame ainult jooksvates hindades (miljonites eurodes) mõõdikut, et tagada võrreldavus hariduskulude tabeliga.
  AND na_item = 'B1GQ' -- B1GQ tähistab SKP-d turuhindades (Eurostati standard).
  AND gdp_amount > 0 -- Välistame puuduvad või vigased kirjed
  AND country_code NOT LIKE 'EA%' -- Välistame summaarse Euro ala
  AND country_code NOT LIKE 'EU%' -- Välistame summaarse Euroopa Liidu
  AND country_code NOT IN ('AL','GE','XK','LI','ME','MK','UK','UA');
