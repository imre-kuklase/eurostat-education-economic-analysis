-- Finantsandmete puhastamine ja unpivotimine (Kogukulud miljonites eurodes)
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.finance_fact` AS
WITH raw_split AS (
  SELECT
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(1)]) AS unit_code,    -- MIO_EUR
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(2)]) AS sector_code,  -- Rahastatav sektor
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS isced_level,  -- Haridustase (isced11)
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(4)]) AS country_code, -- Riigi kood (geo)
    * EXCEPT(string_field_0)
  FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.eurostat_finance_raw`
  WHERE string_field_0 NOT LIKE '%TIME_PERIOD%'
),
unpivoted AS (
  SELECT * FROM raw_split
  UNPIVOT(
    value FOR raw_field IN (
      string_field_1, string_field_2, string_field_3, string_field_4, 
      string_field_5, string_field_6, string_field_7, string_field_8, 
      string_field_9, string_field_10, string_field_11
    )
  )
),
calculated_data AS (
  SELECT 
    country_code,
    sector_code,
    isced_level,
    unit_code,
    CASE 
      WHEN raw_field = 'string_field_1' THEN 2012
      WHEN raw_field = 'string_field_2' THEN 2013
      WHEN raw_field = 'string_field_3' THEN 2014
      WHEN raw_field = 'string_field_4' THEN 2015
      WHEN raw_field = 'string_field_5' THEN 2016
      WHEN raw_field = 'string_field_6' THEN 2017
      WHEN raw_field = 'string_field_7' THEN 2018
      WHEN raw_field = 'string_field_8' THEN 2019
      WHEN raw_field = 'string_field_9' THEN 2020
      WHEN raw_field = 'string_field_10' THEN 2021
      WHEN raw_field = 'string_field_11' THEN 2022
    END AS year,
    -- Puhastame numbrid
    SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9.]', '') AS FLOAT64) AS expenditure_amount
  FROM unpivoted
  WHERE value NOT LIKE '%:%' -- Eemaldame Eurostati tühja andme sümboli
)
SELECT * FROM calculated_data 
WHERE expenditure_amount > 0;
