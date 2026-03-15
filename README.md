# Euroopa kõrghariduse ja majandusnäitajate analüüs (2005–2024)

See projekt analüüsib seoseid kõrghariduse struktuuri (era- vs avalik sektor), hariduse rahastamise ja riikide majanduskasvu vahel.

## Projekti etapid
- [x] **I etapp:** Üliõpilaste arv ja struktuur (Eurostat UOE andmed).
- [ ] **II etapp:** Hariduse rahastamise andmete integreerimine.
- [ ] **III etapp:** Majandusnäitajate (SKP kasv) lisamine ja korrelatsioonianalüüs.
- [ ] **IV etapp:** Visualiseerimine Power BI-s.

## Tehniline arhitektuur
Andmed on laaditud **Google Cloud Storage** bucketist **BigQuery** andmelattu. Andmemudel on ehitatud **Star Schema** põhimõttel.

## Andmearhitektuur ja skeem

Projekt kasutab **Star Schema** (tähtskeemi) lähenemist, mis on standardne ja optimaalne lahendus BI-raportite (Power BI) jaoks.

### Faktitabel
- **`high_education_final`**: Sisaldab numbrilisi väärtusi (`student_count`) ja välisvõtmeid (FK), mis seovad andmed dimensioonidega.

### Dimensioonitabelid
1. **`dim_country`**: Normaliseeritud riiginimed ja regioonide jaotus. Eristab üksikriigid agregaatidest.
2. **`dim_sector`**: Klassifitseerib õppeasutuse omanikuvormi (Avalik vs Era).
3. **`dim_isced`**: Määratleb haridustasemed ja sisaldab loogilist sorteerimisjärjestust (`sort_order`).

### Seosed (Entity Relationship)
- `high_education_final.country_code` <-> `dim_country.country_code` (Many-to-One)
- `high_education_final.sector_code` <-> `dim_sector.sector_code` (Many-to-One)
- `high_education_final.isced_level` <-> `dim_isced.isced_level` (Many-to-One)
