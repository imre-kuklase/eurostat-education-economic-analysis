/*
  TABEL: prod_dim_sector
  KIRJELDUS: Sektorite harmoniseerimine haridus- ja finantsandmete vahel.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_sector` AS
SELECT * FROM UNNEST([
  -- Hariduse koodid (stg_high_education)
  STRUCT('PUB' AS sector_code, 'Avalikud õppeasutused' AS sector_name_et, 'Public institutions' AS sector_name_en, 'Avalik sektor' AS sector_group_et, 'Public sector' AS sector_group_en),
  ('PRV', 'Eraõppeasutused', 'Private institutions', 'Erasektor', 'Private sector'),

  -- Finantsi koodid (stg_finance)
  ('S13', 'Valitsemissektor', 'General government', 'Avalik sektor', 'Public sector'),
  ('S1D', 'Muud kodumaised sektorid', 'Other domestic sectors', 'Erasektor', 'Private sector'),
  ('S1D_OTH', 'Muud erasektori üksused', 'Other private entities', 'Erasektor', 'Private sector')

  -- Kontrollväärtus / Baasnäitaja (Vajalik osakaalude arvutamiseks)
  ('S1', 'Kogu majandus', 'Total economy', 'Kokku', 'Total')
]);
