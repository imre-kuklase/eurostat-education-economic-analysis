/*
  TABEL: prod_dim_country
  KIRJELDUS: Riikide nimekiri koos regioonidega analüüsi gruppimiseks.
*/

CREATE OR REPLACE TABLE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.prod_dim_country` AS
SELECT * FROM UNNEST([
  -- Regioon: Põhjamaad (Nordics)
  STRUCT('DK' AS country_code, 'Taani' AS country_name_et, 'Denmark' AS country_name_en, 'Põhjamaad' AS region_et, 'Nordics' AS region_en),
  ('FI', 'Soome', 'Finland', 'Põhjamaad', 'Nordics'),
  ('IS', 'Island', 'Iceland', 'Põhjamaad', 'Nordics'),
  ('NO', 'Norra', 'Norway', 'Põhjamaad', 'Nordics'),
  ('SE', 'Rootsi', 'Sweden', 'Põhjamaad', 'Nordics'),

  -- Regioon: Baltikum (Baltics)
  ('EE', 'Eesti', 'Estonia', 'Baltikum', 'Baltics'),
  ('LV', 'Läti', 'Latvia', 'Baltikum', 'Baltics'),
  ('LT', 'Leedu', 'Lithuania', 'Baltikum', 'Baltics'),

  -- Regioon: Lääne-Euroopa (Western Europe)
  ('AT', 'Austria', 'Austria', 'Lääne-Euroopa', 'Western Europe'),
  ('BE', 'Belgia', 'Belgium', 'Lääne-Euroopa', 'Western Europe'),
  ('CH', 'Šveits', 'Switzerland', 'Lääne-Euroopa', 'Western Europe'),
  ('DE', 'Saksamaa', 'Germany', 'Lääne-Euroopa', 'Western Europe'),
  ('FR', 'Prantsusmaa', 'France', 'Lääne-Euroopa', 'Western Europe'),
  ('IE', 'Iirimaa', 'Ireland', 'Lääne-Euroopa', 'Western Europe'),
  ('LU', 'Luksemburg', 'Luxembourg', 'Lääne-Euroopa', 'Western Europe'),
  ('NL', 'Madalmaad', 'Netherlands', 'Lääne-Euroopa', 'Western Europe'),

  -- Regioon: Lõuna-Euroopa (Southern Europe)
  ('CY', 'Küpros', 'Cyprus', 'Lõuna-Euroopa', 'Southern Europe'),
  ('EL', 'Kreeka', 'Greece', 'Lõuna-Euroopa', 'Southern Europe'),
  ('ES', 'Hispaania', 'Spain', 'Lõuna-Euroopa', 'Southern Europe'),
  ('IT', 'Itaalia', 'Italy', 'Lõuna-Euroopa', 'Southern Europe'),
  ('MT', 'Malta', 'Malta', 'Lõuna-Euroopa', 'Southern Europe'),
  ('PT', 'Portugal', 'Portugal', 'Lõuna-Euroopa', 'Southern Europe'),

  -- Regioon: Kesk- ja Ida-Euroopa (Central & Eastern Europe)
  ('BG', 'Bulgaaria', 'Bulgaria', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('CZ', 'Tšehhi', 'Czechia', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('HR', 'Horvaatia', 'Croatia', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('HU', 'Ungari', 'Hungary', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('PL', 'Poola', 'Poland', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('RO', 'Rumeenia', 'Romania', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('SI', 'Sloveenia', 'Slovenia', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),
  ('SK', 'Slovakkia', 'Slovakia', 'Kesk- ja Ida-Euroopa', 'Central & Eastern Europe'),

  -- Regioon: Muu / Kandidaatriigid (Balkans & Others)
  ('RS', 'Serbia', 'Serbia', 'Balkani ja muud riigid', 'Balkans & Others'),
  ('BA', 'Bosnia ja Hertsegoviina', 'Bosnia and Herzegovina', 'Balkani ja muud riigid', 'Balkans & Others'),
  ('TR', 'Türgi', 'Turkey', 'Balkani ja muud riigid', 'Balkans & Others')
])
ORDER BY country_code;
