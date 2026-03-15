CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education` AS
WITH raw_split AS (
  SELECT
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(2)]) AS sector_code,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS isced_level,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(4)]) AS country_code,
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
  country_code, sector_code, isced_level,
  CASE 
    WHEN raw_field = 'string_field_1' THEN 2005
    -- ... (lisa siia kõik aastad 2005-2022 nagu varem tegid) ...
    WHEN raw_field = 'string_field_18' THEN 2022
  END AS year,
  SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9]', '') AS INT64) AS student_count
FROM unpivoted
WHERE value NOT LIKE '%:%';
