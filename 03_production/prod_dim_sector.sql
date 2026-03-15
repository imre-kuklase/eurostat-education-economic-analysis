-- Luuakse või asendatakse õppeasutuse sektori dimensioonitabel
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_sector` AS
SELECT DISTINCT 
  sector_code, -- Algne kood faktitabelist (nt PUB, PRV_IND)
  
  -- Sektori koodi tõlkimine eestikeelseks nimetuseks
  CASE 
    WHEN sector_code = 'PUB' THEN 'Avalik-õiguslik'
    WHEN sector_code = 'PRV' THEN 'Eraõiguslik (kokku)'
    WHEN sector_code = 'PRV_DEP' THEN 'Riigist sõltuv eraõiguslik'
    WHEN sector_code = 'PRV_IND' THEN 'Sõltumatu eraõiguslik'
    WHEN sector_code = 'TOT_SEC' THEN 'Kõik sektorid kokku'
    ELSE sector_code 
  END AS sector_name_et,

  -- Sektori koodi tõlkimine ingliskeelseks nimetuseks
  CASE 
    WHEN sector_code = 'PUB' THEN 'Public'
    WHEN sector_code = 'PRV' THEN 'Private (total)'
    WHEN sector_code = 'PRV_DEP' THEN 'Government-dependent private'
    WHEN sector_code = 'PRV_IND' THEN 'Independent private'
    WHEN sector_code = 'TOT_SEC' THEN 'Total sectors'
    ELSE sector_code 
  END AS sector_name_en,

  -- Sektorite grupeerimine analüüsiks (Erasektor vs Avalik sektor)
  CASE 
    WHEN sector_code IN ('PRV', 'PRV_DEP', 'PRV_IND') THEN 'Erasektor'
    WHEN sector_code = 'PUB' THEN 'Avalik sektor'
    ELSE 'Muu/Agregeeritud'
  END AS sector_group_et,

  -- Sektorite grupeerimine inglise keeles
  CASE 
    WHEN sector_code IN ('PRV', 'PRV_DEP', 'PRV_IND') THEN 'Private Sector'
    WHEN sector_code = 'PUB' THEN 'Public Sector'
    ELSE 'Other/Aggregate'
  END AS sector_group_en
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.high_education_final`;
