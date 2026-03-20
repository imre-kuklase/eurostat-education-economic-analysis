/*
  SKRIPT: stg_finance.sql
  EESMÄRK: Hariduskulude andmete depivoteerimine ja puhastus.
  TRANSFORMATSIOONID: 
    1. SPLIT: Eraldame metadata (freq, unit, sector, isced11, geo).
    2. UNPIVOT: Teisendame aastate veerud ridadeks.
    3. REGEXP & EXTRACT: Eraldame Eurostati märkmed (lipud) väärtustest eraldi veergu 'flag_code'. Võimaldab hoida arvulised väärtused puhtana (FLOAT64) ja säilitada metaandmed analüüsiks.
        - 'b': Break in time series - Aegrea katkemine. Metoodika või andmeallikas on muutunud (Selgitab järske hüppeid graafikul)
        - 'p': Provisional - Esialgne. Need on värsked andmed, mis võivad hiljem korrigeeruda (Tavaliselt viimase aasta andmete juures)
        - 'd': Definition differs - Definitsioon erineb. Andmed ei vasta 100% standardile, aga on võrreldavad (Märguanne, et riik raporteerib midagi veidi teisiti)
        - 'e': Estimated - Hinnatud. Eurostat või riik on puuduva osa tuletanud mudelitega (Kasutatakse päris küsitlusandmete puudumisel)
        - 'u': Low reliability - Väike usaldusväärsus. Valimi suurus oli liiga väike (Tuleb olla ettevaatlik ridade tõlgendamisel)
        - 'c': Confidential - Salastatud. Ärihuvide / riikliku julgeoleku või muu kaitseks andmete salastatamine. (nt. kui riigis on ainult üks erakool, võidakse andmed salastada, et mitte avaldada kooli ärisaladust)
        - 'n': Not significant - Statistiliselt mitteoluline. Väärtus on nii väike, et ümardub nulliks.
        - 'z': Not applicable - Pole asjakohane / ei kohaldata. Viitab sellele, et kontseptsioon või andmepunkt ei ole antud riigi või sektori puhul üldse võimalik.
        - ':': Missing value - Puuduv väärtus (filtreeritakse välja.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_finance` AS
WITH raw_split AS (
  SELECT
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(0)]) AS freq,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(1)]) AS unit_code,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(2)]) AS sector_code,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(3)]) AS isced_level,
    TRIM(SPLIT(string_field_0, ',')[SAFE_OFFSET(4)]) AS country_code,
    * EXCEPT(string_field_0)
  FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.land_finance`
  WHERE string_field_0 NOT LIKE '%TIME_PERIOD%'
),
unpivoted AS (
  SELECT * FROM raw_split
  UNPIVOT(
    value FOR raw_field IN (
      string_field_1, string_field_2, string_field_3, string_field_4, string_field_5,
      string_field_6, string_field_7, string_field_8, string_field_9, string_field_10, 
      string_field_11
    )
  )
)
SELECT 
  country_code,
  freq,
  unit_code,
  sector_code,
  isced_level,
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
  -- 1. PUHAS NUMBER: eemaldame kõik peale numbrite ja punkti
  SAFE_CAST(REGEXP_REPLACE(value, r'[^0-9.]', '') AS FLOAT64) AS expenditure_amount,
  -- 2. LIPU KOOD: otsime üles kõik tähed (a-z) ja paneme need eraldi veergu
  -- Kui tähte pole, jääb NULL (st. puhas andmepunkt)
  TRIM(REGEXP_EXTRACT(value, r'[a-z]+')) AS flag_code
FROM unpivoted
WHERE value NOT LIKE '%:%';
