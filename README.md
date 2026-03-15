# Euroopa kõrghariduse ja majandusnäitajate analüüs (2005–2024)

See projekt analüüsib seoseid kõrghariduse struktuuri (era- vs avalik sektor), hariduse rahastamise ja riikide majanduskasvu vahel.

## Projekti etapid
- [x] **I etapp:** Üliõpilaste arv ja struktuur (Eurostat UOE andmed).
- [ ] **II etapp:** Hariduse rahastamise andmete integreerimine.
- [ ] **III etapp:** Majandusnäitajate (SKP kasv) lisamine ja korrelatsioonianalüüs.
- [ ] **IV etapp:** Visualiseerimine Power BI-s.

## Andmeallikad

Analüüsis kasutatakse **Eurostat** avalikke andmebaase:
1. **Üliõpilaste arv ja struktuur:** [educ_uoe_enrt01](https://ec.europa.eu/eurostat/databrowser/view/educ_uoe_enrt01/default/table?lang=en) – hõlmab õppurite arvu riigiti, haridustaseme ja asutuse sektori lõikes.
2. **Hariduse rahastamine:** [educ_uoe_finf01](https://ec.europa.eu/eurostat/databrowser/view/educ_uoe_finf01/default/table?lang=en) – näitab rahavoogusid allikate (avalik/era) ja saajate (avalik/era asutused) vahel.

## Tehniline arhitektuur
Andmed on laaditud **Google Cloud Storage** bucketist **BigQuery** andmelattu. Andmemudel on ehitatud **Star Schema** põhimõttel.

## Andmearhitektuur ja skeem

Projekt kasutab **Star Schema** (tähtskeemi) lähenemist, mis on standardne ja optimaalne lahendus BI-raportite (Power BI) jaoks.

### Faktitabel
- **`high_education_final`**: Sisaldab numbrilisi väärtusi (`student_count`) ja välisvõtmeid (FK), mis seovad andmed dimensioonidega.
  ### Faktitabeli struktuur (`high_education_final`)
| Field name | Data type | Description |
| :--- | :--- | :--- |
| country_code | STRING | Riigi ISO kood |
| sector_code | STRING | Õppeasutuse sektori kood |
| isced_level | STRING | Haridustaseme kood |
| year | INTEGER | Aasta |
| student_count | INTEGER | Tudengite arv |
  

### Dimensioonitabelid
1. **`dim_country`**: Normaliseeritud riiginimed ja regioonide jaotus. Eristab üksikriigid agregaatidest.
     ### Dimensioonide tabeli struktuur (`dim_country`)
| Field name | Data type | Description |
| :--- | :--- | :--- |
| country_code | STRING | Riigi või regiooni kood (Primary Key) |
| country_name_et | STRING | Riigi nimi eesti keeles |
| country_name_en | STRING | Riigi nimi inglise keeles |
| country_type_et | STRING | Üksuse tüüp: Üksikriik või Regioon |
| country_type_en | STRING | Üksuse tüüp: Single Country või Region |

3. **`dim_sector`**: Klassifitseerib õppeasutuse omanikuvormi (Avalik vs Era).
  ### Dimensioonide tabeli struktuur (`dim_sector`)
| Field name | Data type | Description |
| :--- | :--- | :--- |
| sector_code | STRING | Sektori kood (Primary Key) |
| sector_name_et | STRING | Sektori detailne nimetus eesti keeles |
| sector_name_en | STRING | Sektori detailne nimetus inglise keeles |
| sector_group_et | STRING | Üldine grupeering: Avalik või Erasektor (ET) |
| sector_group_en | STRING | Üldine grupeering: Public või Private Sector (EN) |

4. **`dim_isced`**: Määratleb haridustasemed ja sisaldab loogilist sorteerimisjärjestust (`sort_order`).
  ### Dimensioonide tabeli struktuur (`dim_isced`)
| Field name | Data type | Description |
| :--- | :--- | :--- |
| isced_level | STRING | ISCED taseme kood (Primary Key) |
| isced_name_et | STRING | Taseme detailne nimetus eesti keeles |
| isced_name_en | STRING | Taseme detailne nimetus inglise keeles |
| isced_group_et | STRING | Üldine taseme grupp (nt Bakalaureuseõpe) (ET) |
| isced_group_en | STRING | Üldine taseme grupp (nt Bachelor's) (EN) |
| sort_order | INTEGER | Loogiline järjekord graafikutel kuvamiseks (1-5) |

### Seosed (Entity Relationship)
- `high_education_final.country_code` <-> `dim_country.country_code` (Many-to-One)
- `high_education_final.sector_code` <-> `dim_sector.sector_code` (Many-to-One)
- `high_education_final.isced_level` <-> `dim_isced.isced_level` (Many-to-One)
