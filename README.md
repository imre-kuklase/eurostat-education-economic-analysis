# Euroopa kõrghariduse ja majandusnäitajate analüüs (2005–2024)

See projekt analüüsib seoseid kõrghariduse struktuuri (era- vs avalik sektor), hariduse rahastamise ja riikide majanduskasvu vahel.

## Projekti etapid
- [x] **I etapp:** Üliõpilaste arv ja struktuur (Eurostat UOE andmed).
- [ ] **II etapp:** Hariduse rahastamise andmete integreerimine.
- [ ] **III etapp:** Majandusnäitajate (SKP kasv) lisamine ja korrelatsioonianalüüs.
- [ ] **IV etapp:** Visualiseerimine Power BI-s.

## Tehniline arhitektuur
Andmed on laaditud **Google Cloud Storage** bucketist **BigQuery** andmelattu. Andmemudel on ehitatud **Star Schema** põhimõttel.
