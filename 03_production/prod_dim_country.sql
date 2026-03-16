/*
  TABEL: prod_dim_country
  KIRJELDUS: Riikide nimekiri (ISO koodid, ET/EN nimed).
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_country` AS
SELECT * FROM UNNEST([
  STRUCT('AT' AS country_code, 'Austria' AS country_name_et, 'Austria' AS country_name_en),
  ('BE', 'Belgia', 'Belgium'),
  ('BG', 'Bulgaaria', 'Bulgaria'),
  ('CH', 'Šveits', 'Switzerland'),
  ('CY', 'Küpros', 'Cyprus'),
  ('CZ', 'Tšehhi', 'Czechia'),
  ('DE', 'Saksamaa', 'Germany'),
  ('DK', 'Taani', 'Denmark'),
  ('EE', 'Eesti', 'Estonia'),
  ('EL', 'Kreeka', 'Greece'),
  ('ES', 'Hispaania', 'Spain'),
  ('FI', 'Soome', 'Finland'),
  ('FR', 'Prantsusmaa', 'France'),
  ('HR', 'Horvaatia', 'Croatia'),
  ('HU', 'Ungari', 'Hungary'),
  ('IE', 'Iirimaa', 'Ireland'),
  ('IS', 'Island', 'Iceland'),
  ('IT', 'Itaalia', 'Italy'),
  ('LT', 'Leedu', 'Lithuania'),
  ('LU', 'Luksemburg', 'Luxembourg'),
  ('LV', 'Läti', 'Latvia'),
  ('MT', 'Malta', 'Malta'),
  ('NL', 'Madalmaad', 'Netherlands'),
  ('NO', 'Norra', 'Norway'),
  ('PL', 'Poola', 'Poland'),
  ('PT', 'Portugal', 'Portugal'),
  ('RO', 'Rumeenia', 'Romania'),
  ('SE', 'Rootsi', 'Sweden'),
  ('SI', 'Sloveenia', 'Slovenia'),
  ('SK', 'Slovakkia', 'Slovakia'),
  ('UK', 'Ühendkuningriik', 'United Kingdom'),
  ('RS', 'Serbia', 'Serbia'),
  ('BA', 'Bosnia ja Hertsegoviina', 'Bosnia and Herzegovina'),
  ('TR', 'Türgi', 'Turkey'),
  ('AL', 'Albaania', 'Albania'),
  ('ME', 'Montenegro', 'Montenegro'),
  ('MK', 'Põhja-Makedoonia', 'North Macedonia'),
  ('GE', 'Gruusia', 'Georgia'),
  ('LI', 'Liechtenstein', 'Liechtenstein')
])
ORDER BY
  country_code;
