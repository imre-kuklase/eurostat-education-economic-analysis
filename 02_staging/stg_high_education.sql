/*
  SKRIPT: stg_high_education.sql
  EESMÄRK: Üliõpilaste arvu andmete täielik laadimine koos kõigi metadata dimensioonidega.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education` AS
WITH raw_split AS (
  SELECT
    -- Metadata osadeks lammutamine vastavalt TSV päisele
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(0)]) AS freq_code,     -- A (Annual)
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(1)]) AS unit_code,     -- NR (Number)
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(2)]) AS worktime_code, -- FT (Full-time) jne
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS sector_code,   -- PRV, PUB jne
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(4)]) AS sex_code,      -- T (Total), F, M
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(5)]) AS isced_level,   -- ED5, ED6 jne
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(6)]) AS country_code,  -- geo (EE, TR jne)
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
SELECT DISTINCT -- Kasutame DISTINCT-i, et vältida dubleerivaid ridu
  country_code,
  freq_code,
  unit_code,
  worktime_code,
  sector_code,
  sex_code,
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
  -- Puhastame väärtuse märkmetest (b, e, d) ja teisendame numbriliseks
  SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9]', '') AS INT64) AS student_count
FROM unpivoted
-- Filtreerime välja tühjad väärtused (Eurostati ":" märk)
WHERE value NOT LIKE '%:%' 
  AND value IS NOT NULL
  AND value != '';
