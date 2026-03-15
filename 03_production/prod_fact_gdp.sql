/*
  TABEL: prod_fact_gdp
  KIRJELDUS: Riikide SKP näitajad jooksvates hindades (Current Prices).
  ALLIKAS: stg_gdp
  AJARAAM: 2012-2024 (Sünkroniseeritud haridusandmetega)
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_gdp` AS
SELECT 
  country_code,
  year,
  unit AS unit_code,  -- Kasutame ainult jooksvates hindades (miljonites eurodes) mõõdikut, et tagada võrreldavus hariduskulude tabeliga. 
  na_item, -- B1GQ tähistab SKP-d turuhindades (Eurostati standard).
  gdp_amount
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_gdp`
WHERE year BETWEEN 2012 AND 2022 
  AND unit = 'CP_MEUR' 
  AND na_item = 'B1GQ'
  AND gdp_amount > 0; -- Välistame puuduvad või vigased kirjed
