/*
  TABEL: prod_fact_education
  KIRJELDUS: Õppurite jahunemine riigiti era- ja avaliku sektori kaupa
  ALLIKAS: stg_high_education
  FILTER: 2012-2022, sünkroniseeritud teiste faktitabelitega.

  MÄRKUS: Sisaldab andmekvaliteedi parandust (Hotfix) Eesti (EE) andmetele 
  perioodil 2012-2015, kus avaliku ja erasektori sildid olid Eurostati 
  algallikas vahetuses.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_fact_education` AS
SELECT 
  country_code,
  isced_level,
  'ED5-8' AS isced_level_group,
  -- "Hotfix" Eesti 2013-2015 sektorite vahetuse jaoks
  CASE 
    WHEN country_code = 'EE' AND year < 2016 AND sector_code = 'PUB' THEN 'PRV'
    WHEN country_code = 'EE' AND year < 2016 AND sector_code = 'PRV' THEN 'PUB'
    ELSE sector_code 
  END AS sector_code,
  year,
  student_count,
  flag_code
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.stg_high_education`
WHERE
  -- Regiooni ja riikide välistamine
  AND country_code NOT LIKE 'EA%' -- Välistame summaarse Euro ala
  AND country_code NOT LIKE 'EU%' -- Välistame summaarse Euroopa Liidu
  AND country_code NOT IN ('AL','GE','XK','LI','ME','MK','UK',UA)
  -- Filtreeritud ainult kõrghariduse tasemed
  AND isced_level IN ('ED5','ED6','ED7','ED8')
  -- Fookus: Avalik vs Erasektor
  AND sector_code IN ('PUB','PRV')
  -- Granulaarsus lukustatud koondsummadele
  AND sex_code = 'T'
  AND worktime_code = 'TOTAL'
  -- Uurimustöö ajaline raam
  AND year BETWEEN 2012 AND 2022
ORDER BY
  year,
  country_code,
  isced_level,
  sector_code
