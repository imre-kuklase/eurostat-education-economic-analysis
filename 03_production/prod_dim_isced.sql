/*
  TABEL: prod_dim_isced
  KIRJELDUS: Haridustasemed koos agregaat-kategooriaga finantsanalüüsi jaoks.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_isced` AS
SELECT * FROM UNNEST([
  -- KÕRGHARIDUSE AGREGAAT (Finantsandmete jaoks)
  STRUCT('ED5-8' AS isced_level, 'Kõrgharidus (kokku)' AS isced_name_et, 'Tertiary education (total)' AS isced_name_en, 'Agregaat' AS level_type, 0 AS sort_order),
  
  -- DETAILSED TASEMED (Tudengite arvu analüüsi jaoks)
  ('ED5', 'Lühitsükli kõrgharidus', 'Short-cycle tertiary', 'Detailne', 1),
  ('ED6', 'Bakalaureuseõpe', 'Bachelor or equivalent', 'Detailne', 2),
  ('ED7', 'Magistriõpe', 'Master or equivalent', 'Detailne', 3),
  ('ED8', 'Doktoriõpe', 'Doctoral or equivalent', 'Detailne', 4)
]);
