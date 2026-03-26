/*
  TABEL: prod_dim_isced
  KIRJELDUS: Haridustasemed.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_isced` AS
SELECT * FROM UNNEST([
  -- DETAILSED TASEMED (Tudengite arvu analüüsi jaoks)
  STRUCT('ED5' AS isced_level, 'Lühitsükli kõrgharidus' AS isced_name_et, 'Short-cycle tertiary' AS isced_name_en, 'ED5-8' AS isced_level_group, 1 AS sort_order),
  ('ED6', 'Bakalaureuseõpe', 'Bachelor or equivalent', 'ED5-8', 2),
  ('ED7', 'Magistriõpe', 'Master or equivalent', 'ED5-8', 3),
  ('ED8', 'Doktoriõpe', 'Doctoral or equivalent', 'ED5-8', 4)
]);
