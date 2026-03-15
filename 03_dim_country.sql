-- Luuakse või asendatakse riikide dimensioonitabel
CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.dim_country` AS
SELECT DISTINCT 
  country_code, -- Algne Eurostati kahetäheline riigikood (PK)
  
  -- Riigi nime teisendamine koodist eestikeelseks nimeks
  CASE 
    WHEN country_code = 'AL' THEN 'Albaania' WHEN country_code = 'AT' THEN 'Austria'
    WHEN country_code = 'BA' THEN 'Bosnia ja Hertsegoviina' WHEN country_code = 'BE' THEN 'Belgia'
    WHEN country_code = 'BG' THEN 'Bulgaaria' WHEN country_code = 'CH' THEN 'Šveits'
    WHEN country_code = 'CY' THEN 'Küpros' WHEN country_code = 'CZ' THEN 'Tšehhi'
    WHEN country_code = 'DE' THEN 'Saksamaa' WHEN country_code = 'DK' THEN 'Taani'
    WHEN country_code = 'EE' THEN 'Eesti' WHEN country_code = 'EL' THEN 'Kreeka'
    WHEN country_code = 'ES' THEN 'Hispaania' WHEN country_code = 'FI' THEN 'Soome'
    WHEN country_code = 'FR' THEN 'Prantsusmaa' WHEN country_code = 'GE' THEN 'Gruusia'
    WHEN country_code = 'HR' THEN 'Horvaatia' WHEN country_code = 'HU' THEN 'Ungari'
    WHEN country_code = 'IE' THEN 'Iirimaa' WHEN country_code = 'IS' THEN 'Island'
    WHEN country_code = 'IT' THEN 'Itaalia' WHEN country_code = 'LI' THEN 'Liechtenstein'
    WHEN country_code = 'LT' THEN 'Leedu' WHEN country_code = 'LU' THEN 'Luksemburg'
    WHEN country_code = 'LV' THEN 'Läti' WHEN country_code = 'ME' THEN 'Montenegro'
    WHEN country_code = 'MK' THEN 'Põhja-Makedoonia' WHEN country_code = 'MT' THEN 'Malta'
    WHEN country_code = 'NL' THEN 'Madalmaad' WHEN country_code = 'NO' THEN 'Norra'
    WHEN country_code = 'PL' THEN 'Poola' WHEN country_code = 'PT' THEN 'Portugal'
    WHEN country_code = 'RO' THEN 'Rumeenia' WHEN country_code = 'RS' THEN 'Serbia'
    WHEN country_code = 'SE' THEN 'Rootsi' WHEN country_code = 'SI' THEN 'Sloveenia'
    WHEN country_code = 'SK' THEN 'Slovakkia' WHEN country_code = 'TR' THEN 'Türgi'
    WHEN country_code = 'UK' THEN 'Ühendkuningriik'
    WHEN country_code = 'EU27_2020' THEN 'Euroopa Liit (27 riiki, al 2020)'
    WHEN country_code = 'EU28' THEN 'Euroopa Liit (28 riiki)'
    ELSE country_code 
  END AS country_name_et,

  -- Riigi nime teisendamine koodist ingliskeelseks nimeks
  CASE 
    WHEN country_code = 'AL' THEN 'Albania' WHEN country_code = 'AT' THEN 'Austria'
    WHEN country_code = 'BA' THEN 'Bosnia and Herzegovina' WHEN country_code = 'BE' THEN 'Belgium'
    WHEN country_code = 'BG' THEN 'Bulgaria' WHEN country_code = 'CH' THEN 'Switzerland'
    WHEN country_code = 'CY' THEN 'Cyprus' WHEN country_code = 'CZ' THEN 'Czechia'
    WHEN country_code = 'DE' THEN 'Germany' WHEN country_code = 'DK' THEN 'Denmark'
    WHEN country_code = 'EE' THEN 'Estonia' WHEN country_code = 'EL' THEN 'Greece'
    WHEN country_code = 'ES' THEN 'Spain' WHEN country_code = 'FI' THEN 'Finland'
    WHEN country_code = 'FR' THEN 'France' WHEN country_code = 'GE' THEN 'Georgia'
    WHEN country_code = 'HR' THEN 'Croatia' WHEN country_code = 'HU' THEN 'Hungary'
    WHEN country_code = 'IE' THEN 'Ireland' WHEN country_code = 'IS' THEN 'Iceland'
    WHEN country_code = 'IT' THEN 'Italy' WHEN country_code = 'LI' THEN 'Liechtenstein'
    WHEN country_code = 'LT' THEN 'Lithuania' WHEN country_code = 'LU' THEN 'Luxembourg'
    WHEN country_code = 'LV' THEN 'Latvia' WHEN country_code = 'ME' THEN 'Montenegro'
    WHEN country_code = 'MK' THEN 'North Macedonia' WHEN country_code = 'MT' THEN 'Malta'
    WHEN country_code = 'NL' THEN 'Netherlands' WHEN country_code = 'NO' THEN 'Norway'
    WHEN country_code = 'PL' THEN 'Poland' WHEN country_code = 'PT' THEN 'Portugal'
    WHEN country_code = 'RO' THEN 'Romania' WHEN country_code = 'RS' THEN 'Serbia'
    WHEN country_code = 'SE' THEN 'Sweden' WHEN country_code = 'SI' THEN 'Slovenia'
    WHEN country_code = 'SK' THEN 'Slovakia' WHEN country_code = 'TR' THEN 'Turkey'
    WHEN country_code = 'UK' THEN 'United Kingdom'
    WHEN country_code = 'EU27_2020' THEN 'European Union (27 countries from 2020)'
    WHEN country_code = 'EU28' THEN 'European Union (28 countries)'
    ELSE country_code 
  END AS country_name_en,

  -- Määratletakse, kas tegu on riigi või riikide ühendusega (agregaadiga)
  CASE WHEN country_code LIKE 'EU%' THEN 'Regioon' ELSE 'Üksikriik' END AS country_type_et,
  CASE WHEN country_code LIKE 'EU%' THEN 'Region' ELSE 'Single Country' END AS country_type_en
FROM `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.high_education_final`;
