CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_gdp` AS
WITH raw_split AS (
  SELECT
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(1)]) AS unit,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(2)]) AS na_item,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS country_code,
    * EXCEPT(string_field_0)
  FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.land_gdp`
  WHERE string_field_0 NOT LIKE '%TIME_PERIOD%'
    -- Filtreerime välja protsendid, vajame absoluutväärtusi (miljonites)
    AND (string_field_0 LIKE '%CP_MEUR%' OR string_field_0 LIKE '%CLV%')
    -- Võtame peamise SKP näitaja (B1GQ)
    AND string_field_0 LIKE '%B1GQ%'
),
unpivoted AS (
  SELECT * FROM raw_split
  UNPIVOT(
    value FOR raw_field IN (
      string_field_36, string_field_37, string_field_38, string_field_39, string_field_40,
      string_field_41, string_field_42, string_field_43, string_field_44, string_field_45,
      string_field_46, string_field_47, string_field_48, string_field_49, string_field_50, string_field_51
    )
  )
)
SELECT 
  country_code,
  unit,
  na_item,
  -- Aastate kaardistamine (1975 + (field_nr - 1))
  CAST(REGEXP_REPLACE(raw_field, 'string_field_', '') AS INT64) + 1974 AS year,
  -- Puhastame numbri (eemaldame tühikud ja lipud nagu 'b', 'p', 'd')
  SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9.]', '') AS FLOAT64) AS gdp_amount
FROM unpivoted
WHERE value NOT LIKE '%:%' AND value IS NOT NULL;
