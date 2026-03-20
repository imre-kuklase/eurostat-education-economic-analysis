/*
  TABEL: prod_dim_flags
  EESMÄRK: Eurostati märkmete (lipud) süstematiseerimine ja tõlkimine.
  KATEVUS: Sisaldab standardkoode, kombineeritud koode ja märkusteta andmepunkti kirjeldust.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_flags` AS
-- 1. Standardid lipud
SELECT 
  'b' AS flag_code, 
  'Break in time series' AS flag_name_en, 
  'Aegrea katkemine' AS flag_name_et, 
  'Methodology or data source has changed.' AS flag_description_en, 
  'Metoodika või andmeallikas on muutunud (selgitab järske hüppeid graafikul).' AS flag_description_et
UNION ALL SELECT 'p', 'Provisional', 'Esialgne', 'Fresh data that may be corrected later.', 'Värsked andmed, mis võivad hiljem korrigeeruda (tavaliselt viimase aasta andmete juures).'
UNION ALL SELECT 'd', 'Definition differs', 'Definitsioon erineb', 'Data does not fully comply with the standard but is comparable.', 'Andmed ei vasta 100% standardile, aga on võrreldavad (märguanne, et riik raporteerib midagi veidi teisiti).'
UNION ALL SELECT 'e', 'Estimated', 'Hinnatud', 'Value estimated by Eurostat or the reporting country.', 'Eurostat või riik on puuduva osa tuletanud mudelitega (kasutatakse päris küsitlusandmete puudumisel).'
UNION ALL SELECT 'u', 'Low reliability', 'Väike usaldusväärsus', 'Sample size was too small for full statistical reliability.', 'Valimi suurus oli liiga väike (tuleb olla ettevaatlik ridade tõlgendamisel).'
UNION ALL SELECT 'c', 'Confidential', 'Salastatud', 'Data hidden for business interests or security purposes.', 'Ärihuvide / riikliku julgeoleku või muu kaitseks andmete salastamine (nt. kui riigis on üks erakool).'
UNION ALL SELECT 'n', 'Not significant', 'Statistiliselt mitteoluline', 'Value is so small it rounds to zero.', 'Väärtus on nii väike, et ümardub nulliks.'
UNION ALL SELECT 'z', 'Not applicable', 'Pole asjakohane / ei kohaldata', 'Concept or data point is not possible for the given country or sector.', 'Viitab sellele, et kontseptsioon või andmepunkt ei ole antud riigi või sektori puhul üldse võimalik.'
UNION ALL SELECT 'i', 'Additional information', 'Täiendav informatsioon', 'Additional context provided by the reporting entity.', 'Täiendav informatsioon.'

-- 2. Kombineeritud lipud (stg-tabelitest tuvastatud)
UNION ALL SELECT 'bd', 'Break & Definition differs', 'Katkemine ja definitsiooni erinevus', 'Combined flag: Methodology change and differing definitions.', 'Metoodika muutus ja definitsiooni erinevus ühes andmepunktis.'
UNION ALL SELECT 'de', 'Definition differs & Estimated', 'Definitsiooni erinevus ja hinnatud väärtus', 'Combined flag: Differing definitions and estimated values.', 'Definitsiooni erinevus ja hinnatud väärtus ühes andmepunktis.'

-- 3. Standardne andmepunkt (Joinimiseks faktitabelite NULL väärtustega)
UNION ALL SELECT NULL, 'Standard data point', 'Standardne andmepunkt', 'Data point without specific quality flags.', 'Märkusteta andmepunkt.';
