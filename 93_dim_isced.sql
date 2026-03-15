-- Luuakse või asendatakse haridustaseme (ISCED) dimensioonitabel
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.dim_isced` AS
SELECT DISTINCT 
  isced_level, -- Rahvusvaheline haridustaseme kood (nt ED6)
  
  -- ISCED koodi tõlkimine eestikeelseks detailseks nimetuseks
  CASE 
    WHEN isced_level = 'ED5' THEN '5. taseme kutseõpe'
    WHEN isced_level = 'ED54' THEN '5. taseme kutseõpe (rakenduslik)'
    WHEN isced_level = 'ED55' THEN '5. taseme kutseõpe (akadeemiline)'
    WHEN isced_level = 'ED5SW' THEN '5. taseme kutseõpe (astmeline)'
    WHEN isced_level = 'ED6' THEN 'Bakalaureuseõpe või samaväärne'
    WHEN isced_level = 'ED64' THEN 'Bakalaureuseõpe (akadeemiline)'
    WHEN isced_level = 'ED65' THEN 'Bakalaureuseõpe (rakenduskõrgharidus)'
    WHEN isced_level = 'ED7' THEN 'Magistriõpe või samaväärne'
    WHEN isced_level = 'ED74' THEN 'Magistriõpe (akadeemiline)'
    WHEN isced_level = 'ED75' THEN 'Magistriõpe (integreeritud/rakenduslik)'
    WHEN isced_level = 'ED8' THEN 'Doktoriõpe või samaväärne'
    WHEN isced_level = 'ED5-8' THEN 'Kõrgharidus kokku (tasemed 5-8)'
    ELSE isced_level 
  END AS isced_name_et,

  -- ISCED koodi tõlkimine ingliskeelseks nimetuseks
  CASE 
    WHEN isced_level = 'ED5' THEN 'Level 5 (Short-cycle tertiary)'
    WHEN isced_level = 'ED54' THEN 'Level 5 (Short-cycle - professional)'
    WHEN isced_level = 'ED55' THEN 'Level 5 (Short-cycle - academic)'
    WHEN isced_level = 'ED5SW' THEN 'Level 5 (Short-cycle - stepwise)'
    WHEN isced_level = 'ED6' THEN 'Bachelor\'s or equivalent'
    WHEN isced_level = 'ED64' THEN 'Bachelor\'s (Academic)'
    WHEN isced_level = 'ED65' THEN 'Bachelor\'s (Professional)'
    WHEN isced_level = 'ED7' THEN 'Master\'s or equivalent'
    WHEN isced_level = 'ED74' THEN 'Master\'s (Academic)'
    WHEN isced_level = 'ED75' THEN 'Master\'s (Professional)'
    WHEN isced_level = 'ED8' THEN 'Doctoral or equivalent'
    WHEN isced_level = 'ED5-8' THEN 'Total Tertiary Education'
    ELSE isced_level 
  END AS isced_name_en,

  -- Haridustasemete koondamine gruppidesse (Slicerite jaoks eesti keeles)
  CASE 
    WHEN isced_level LIKE 'ED5%' THEN '5. taseme kutseõpe'
    WHEN isced_level LIKE 'ED6%' THEN 'Bakalaureuseõpe'
    WHEN isced_level LIKE 'ED7%' THEN 'Magistriõpe'
    WHEN isced_level LIKE 'ED8%' THEN 'Doktoriõpe'
    WHEN isced_level = 'ED5-8' THEN 'Agregeeritud summa'
    ELSE 'Muu'
  END AS isced_group_et,

  -- Haridustasemete koondamine gruppidesse (Slicerite jaoks inglise keeles)
  CASE 
    WHEN isced_level LIKE 'ED5%' THEN 'Level 5 (Short-cycle)'
    WHEN isced_level LIKE 'ED6%' THEN 'Level 6 (Bachelor)'
    WHEN isced_level LIKE 'ED7%' THEN 'Level 7 (Master)'
    WHEN isced_level LIKE 'ED8%' THEN 'Level 8 (Doctorate)'
    WHEN isced_level = 'ED5-8' THEN 'Aggregate Total'
    ELSE 'Other'
  END AS isced_group_en,

  -- Haridustasemete loogiline sorteerimine (1-5), et vältida tähestikulist järjestust
  CASE 
    WHEN isced_level LIKE 'ED5%' THEN 1 
    WHEN isced_level LIKE 'ED6%' THEN 2
    WHEN isced_level LIKE 'ED7%' THEN 3 
    WHEN isced_level LIKE 'ED8%' THEN 4
    ELSE 5
  END AS sort_order
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.high_education_final`;
