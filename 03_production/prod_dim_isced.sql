/*
  TABEL: prod_dim_isced
  KIRJELDUS: Haridustasemed (ISCED 2011 standard) koos sorteerimisjärjekorraga. prod_dim tabelite loomisel kasutatud ainult ED5 - ED8 peamiseid kategooriaid.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_isced` AS
SELECT * FROM UNNEST([
  -- KÕRGHARIDUS (ED5-ED8)
  STRUCT('ED5' AS isced_level, 'Lühitsükli kõrgharidus' AS isced_name_et, 'Short-cycle tertiary' AS isced_name_en, 'Kõrgharidus' AS isced_group_et, 'Higher Education' AS isced_group_en, 1 AS sort_order),
  ('ED6', 'Bakalaureuseõpe', 'Bachelor or equivalent', 'Kõrgharidus', 'Higher Education', 2),
  ('ED7', 'Magistriõpe', 'Master or equivalent', 'Kõrgharidus', 'Higher Education', 3),
  ('ED8', 'Doktoriõpe', 'Doctoral or equivalent', 'Kõrgharidus', 'Higher Education', 4)
]);
