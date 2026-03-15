CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_sector` AS
SELECT * FROM UNNEST([
  -- Hariduse koodid (stg_high_education)
  STRUCT(
    'PUB' AS sector_code, 
    'Avalikud õppeasutused' AS sector_name_et, 
    'Public institutions' AS sector_name_en, 
    'Avalik sektor' AS sector_group_et, 
    'Public sector' AS sector_group_en
  ),
  ('PRV', 'Eraõppeasutused', 'Private institutions', 'Eerasektor', 'Private sector'),
  ('PRV_DEP', 'Erasektori sõltuvad asutused', 'Private government-dependent', 'Eerasektor', 'Private sector'),
  ('PRV_IND', 'Erasektori sõltumatud asutused', 'Private independent', 'Eerasektor', 'Private sector'),
  ('TOT_SEC', 'Kõik sektorid kokku', 'Total sectors', 'Kokku', 'Total'),

  -- Finantsi koodid (stg_finance)
  ('S13', 'Valitsemissektor', 'General government', 'Avalik sektor', 'Public sector'),
  ('S1', 'Kogu majandus', 'Total economy', 'Kokku', 'Total'),
  ('S1D', 'Muud kodumaised sektorid', 'Other domestic sectors', 'Eerasektor', 'Private sector'),
  ('S1D_OTH', 'Muud erasektori üksused', 'Other private entities', 'Eerasektor', 'Private sector'),
  ('ORG_INTL', 'Rahvusvahelised organisatsioonid', 'International organisations', 'Määramata', 'Other')
]);
