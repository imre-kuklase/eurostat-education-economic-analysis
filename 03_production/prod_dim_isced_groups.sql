/*
  TABEL: prod_dim_isced
  KIRJELDUS: Agregaat-kategooriaga finantsanalüüsi jaoks.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_isced` AS
SELECT * FROM UNNEST([
  -- KÕRGHARIDUSE AGREGAAT (Finantsandmete jaoks)
  STRUCT('ED5-8' AS isced_level_group, 'Kõrgharidus (kokku)' AS isced_group_name_et, 'Tertiary education (total)' AS isced_group_name_en, 0 AS sort_order),
]);
