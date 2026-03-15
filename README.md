# Euroopa kõrghariduse ja majandusnäitajate analüüs

Antud projekt analüüsib Euroopa kõrghariduse suundumusi, tudengite arvu ja riiklikke hariduskulutusi, kasutades Eurostati andmeid. Projekt on üles ehitatud Medallion-arhitektuuri põhimõttel Google BigQuery keskkonnas.

## Projekti etapid
- [x] **I etapp:** Üliõpilaste arv ja struktuur (Eurostat UOE andmed).
- [x] **II etapp:** Hariduse rahastamise andmete integreerimine.
- [ ] **III etapp:** Majandusnäitajate (SKP kasv) lisamine ja korrelatsioonianalüüs.
- [ ] **IV etapp:** Visualiseerimine Power BI-s.

## Andmeallikad

Analüüsis kasutatakse **Eurostat** avalikke andmebaase:
1. **Üliõpilaste arv ja struktuur:** [educ_uoe_enrt01](https://ec.europa.eu/eurostat/databrowser/view/educ_uoe_enrt01/default/table?lang=en) – hõlmab õppurite arvu riigiti, haridustaseme ja asutuse sektori lõikes.
2. **Hariduse rahastamine:** [educ_uoe_finf01](https://ec.europa.eu/eurostat/databrowser/view/educ_uoe_finf01/default/table?lang=en) – näitab rahavoogusid allikate (avalik/era) ja saajate (avalik/era asutused) vahel.
3. **Riikide GDP:** []() - näitab ...

## Arhitektuur ja Andmevoog
Andmetöötlus on jaotatud kolme kihti, et tagada skaleeritavus ja andmekvaliteet:

1. **01_landing (Bronze):** Toorandmete laadimine Google Cloud Storage'ist BigQuerysse. Andmeid hoitakse algsel kujul ilma muudatusteta.
2. **02_staging (Silver):** Andmete puhastamine ja transformatsioon. Siin toimub aastate unpivot-protsess, andmetüüpide teisendamine (String -> Float/Int) ning vigaste kirjete eemaldamine REGEXP abil.
3. **03_production (Gold):** Lõplik andmemudel (Star Schema). Selles kihis asuvad puhastatud faktitabelid ja dimensioonid, mis on optimeeritud Power BI raportite jaoks.

## Failide struktuur
- 01_landing/ - Skriptid toorandmete laadimiseks (land_ tabelid).
- 02_staging/ - Andmete puhastamise ja unpivotimise loogika (stg_ tabelid).
- 03_production/ - Lõplikud faktitabelid (prod_fact_) ja dimensioonid (prod_dim_).
- README.md - Projekti dokumentatsioon.

## Tehnoloogiad
- Andmeallikas: Eurostat (API/TSV failid).
- Andmeladu: Google BigQuery (SQL).
- Arhitektuur: Medallion (Landing-Staging-Production).
- Visualiseerimine: Power BI (ühendatud BigQueryga).

## Kuidas kasutada
1. Jooksuta skriptid järjekorras 01 -> 02 -> 03.
2. Veendu, et BigQuerys on loodud vastav dataset.
3. Power BI-s kasuta DirectQuery või Import režiimi 03_production kihi tabelite peal.


## SIIT EDASI HAKKAB OSA, MILLE VAJALIKKUS HINNATA JA SISU KORRIGEERIDA JA TÕSTA VAJADUSEL ÜMBER FAILI SEES

### Faktitabelid
1. **`prod_fact_education`**: Sisaldab numbrilisi väärtusi (`student_count`) ja välisvõtmeid (FK), mis seovad andmed dimensioonidega.
2. **`prod_fact_finance`**: Sisaldab ...

### Dimensioonitabelid
1. **`prod_dim_country`**: Normaliseeritud riiginimed ja regioonide jaotus. Eristab üksikriigid agregaatidest.
2. **`prod_dim_sector`**: Klassifitseerib õppeasutuse omanikuvormi (Avalik vs Era).
3. **`prod_dim_isced`**: Määratleb haridustasemed ja sisaldab loogilist sorteerimisjärjestust (`sort_order`).

### Seosed (Entity Relationship)
- `prod_fact_education.country_code` <-> `prod_dim_country.country_code` (Many-to-One)
- `prod_fact_education.sector_code` <-> `prod_dim_sector.sector_code` (Many-to-One)
- `prod_fact_education.isced_level` <-> `prod_dim_isced.isced_level` (Many-to-One)
- `prod_fact_finance.country_code` <-> `prod_dim_country.country_code` (Many-to-One)
- `prod_fact_finance.sector_code` <-> `prod_dim_sector.sector_code` (Many-to-One)
- `prod_fact_finance.isced_level` <-> `prod_dim_isced.isced_level` (Many-to-One)
