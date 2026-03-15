/*
  TABEL: prod_dim_isced
  KIRJELDUS: Haridustasemed (ISCED 2011 standard) koos sorteerimisjärjekorraga.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_isced` AS
SELECT * FROM UNNEST([
  -- KÕRGHARIDUS (ED5-ED8)
  STRUCT('ED5' AS isced_level, 'Lühitsükli kõrgharidus' AS isced_name_et, 'Short-cycle tertiary' AS isced_name_en, 'Kõrgharidus' AS isced_group_et, 'Higher Education' AS isced_group_en, 1 AS sort_order),
  ('ED54', 'Lühitsükkel (kutsesuund)', 'Short-cycle (vocational)', 'Kõrgharidus', 'Higher Education', 2),
  ('ED55', 'Lühitsükkel (akadeemiline)', 'Short-cycle (academic)', 'Kõrgharidus', 'Higher Education', 3),
  ('ED6', 'Bakalaureuseõpe', 'Bachelor or equivalent', 'Kõrgharidus', 'Higher Education', 4),
  ('ED64', 'Bakalaureus (kutsesuund)', 'Bachelor (professional)', 'Kõrgharidus', 'Higher Education', 5),
  ('ED65', 'Bakalaureus (akadeemiline)', 'Bachelor (academic)', 'Kõrgharidus', 'Higher Education', 6),
  ('ED7', 'Magistriõpe', 'Master or equivalent', 'Kõrgharidus', 'Higher Education', 7),
  ('ED74', 'Magister (kutsesuund)', 'Master (professional)', 'Kõrgharidus', 'Higher Education', 8),
  ('ED75', 'Magister (akadeemiline)', 'Master (academic)', 'Kõrgharidus', 'Higher Education', 9),
  ('ED8', 'Doktoriõpe', 'Doctoral or equivalent', 'Kõrgharidus', 'Higher Education', 10),
  ('ED5-8', 'Kõrgharidus kokku', 'Tertiary education (total)', 'Kõrgharidus', 'Higher Education', 11),
  ('ED6-8', 'Kõrgharidus (bakalaureus kuni doktor)', 'Bachelor to doctoral', 'Kõrgharidus', 'Higher Education', 12),
  ('ED5SW', 'Kõrgharidus (asendusandmed)', 'Tertiary (special waiver)', 'Kõrgharidus', 'Higher Education', 13),

  -- KESK- JA KESKERIHARIDUS (ED3-ED4)
  ('ED3', 'Keskharidus', 'Upper secondary', 'Keskharidus', 'Secondary Education', 20),
  ('ED34', 'Keskharidus (üldhariduslik)', 'Upper secondary (general)', 'Keskharidus', 'Secondary Education', 21),
  ('ED35', 'Keskharidus (kutsehariduslik)', 'Upper secondary (vocational)', 'Keskharidus', 'Secondary Education', 22),
  ('ED3_4', 'Kesk- ja keskeriharidus', 'Upper secondary and post-secondary', 'Keskharidus', 'Secondary Education', 23),
  ('ED34_44', 'Üldharidus (kesk- ja keskeri)', 'General (secondary and post-sec)', 'Keskharidus', 'Secondary Education', 24),
  ('ED35_45', 'Kutseharidus (kesk- ja keskeri)', 'Vocational (secondary and post-sec)', 'Keskharidus', 'Secondary Education', 25),
  ('ED4', 'Keskeriharidus (mitte kõrgharidus)', 'Post-secondary non-tertiary', 'Keskharidus', 'Secondary Education', 26),
  ('ED44', 'Keskeriharidus (üldhariduslik)', 'Post-sec non-tertiary (general)', 'Keskharidus', 'Secondary Education', 27),
  ('ED45', 'Keskeriharidus (kutsehariduslik)', 'Post-sec non-tertiary (vocational)', 'Keskharidus', 'Secondary Education', 28),

  -- ALUS- JA PÕHIHARIDUS (ED0-ED2)
  ('ED0', 'Alusharidus', 'Early childhood education', 'Põhiharidus', 'Basic Education', 30),
  ('ED01', 'Alusharidus (eelkool)', 'Pre-primary education', 'Põhiharidus', 'Basic Education', 31),
  ('ED02', 'Alusharidus (baas)', 'Early childhood development', 'Põhiharidus', 'Basic Education', 32),
  ('ED1', 'Algharidus', 'Primary education', 'Põhiharidus', 'Basic Education', 33),
  ('ED1_2', 'Alg- ja põhiharidus', 'Primary and lower secondary', 'Põhiharidus', 'Basic Education', 34),
  ('ED2', 'Põhiharidus (alumine aste)', 'Lower secondary education', 'Põhiharidus', 'Basic Education', 35),
  ('ED24', 'Põhiharidus (üldhariduslik)', 'Lower secondary (general)', 'Põhiharidus', 'Basic Education', 36),
  ('ED25', 'Põhiharidus (kutsehariduslik)', 'Lower secondary (vocational)', 'Põhiharidus', 'Basic Education', 37),
  
  -- LAIAD AGREGAADID
  ('ED02-8', 'Kõik haridustasemed (v.a varajane alusharidus)', 'Total (excl. ED01)', 'Kokku', 'Total', 40)
]);
