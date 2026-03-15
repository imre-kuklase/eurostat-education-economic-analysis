/*
  SKRIPT: stg_high_education.sql
  EESMÄRK: Üliõpilaste arvu andmete unpivot ja puhastus.
  TRANSFORMATSIOONID:
    1. SPLIT: Eraldame metadata (unit, sector, isced, geo).
    2. UNPIVOT: Teisendame aastate veerud ridadeks.
    3. REGEXP: Eemaldame Eurostati märkmed (nagu 'b' - break, 'e' - estimate).
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education` AS
WITH raw_split AS (
  SELECT
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS sector_code,  -- PRV jne
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(5)]) AS isced_level,  -- ED5 jne
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(6)]) AS country_code, -- geo (AL, AT jne)
    * EXCEPT(string_field_0)
  FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.land_high_education`
  WHERE string_field_0 NOT LIKE '%TIME_PERIOD%'
),
unpivoted AS (
  SELECT * FROM raw_split
  UNPIVOT(
    value FOR raw_field IN (
      string_field_1, string_field_2, string_field_3, string_field_4, string_field_5,
      string_field_6, string_field_7, string_field_8, string_field_9, string_field_10,
      string_field_11, string_field_12, string_field_13, string_field_14, string_field_15
    )
  )
)
SELECT 
  country_code,
  sector_code,
  isced_level,
  CASE 
    WHEN raw_field = 'string_field_1' THEN 2005
    WHEN raw_field = 'string_field_2' THEN 2010
    WHEN raw_field = 'string_field_3' THEN 2012
    WHEN raw_field = 'string_field_4' THEN 2013
    WHEN raw_field = 'string_field_5' THEN 2014
    WHEN raw_field = 'string_field_6' THEN 2015
    WHEN raw_field = 'string_field_7' THEN 2016
    WHEN raw_field = 'string_field_8' THEN 2017
    WHEN raw_field = 'string_field_9' THEN 2018
    WHEN raw_field = 'string_field_10' THEN 2019
    WHEN raw_field = 'string_field_11' THEN 2020
    WHEN raw_field = 'string_field_12' THEN 2021
    WHEN raw_field = 'string_field_13' THEN 2022
    WHEN raw_field = 'string_field_14' THEN 2023
    WHEN raw_field = 'string_field_15' THEN 2024
  END AS year,
  SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9]', '') AS INT64) AS student_count
FROM unpivoted
WHERE value NOT LIKE '%:%' AND value IS NOT NULL;
