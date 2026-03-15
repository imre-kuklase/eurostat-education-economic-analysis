/*
  SKRIPT: land_high_education.sql
  EESMÄRK: Eurostati üliõpilaste arvu (enrt01) toorandmete laadimine GCS-ist BigQuerysse.
  FORMAAT: TSV (tab-separated values), metadata esimeses veerus.
*/

LOAD DATA OVERWRITE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.land_high_education`
FROM FILES (
  format = 'CSV',
  uris = ['gs://kursusetoo/estat_educ_uoe_enrt01.tsv'],
  field_delimiter = '\t',
  skip_leading_rows = 1,
  allow_jagged_rows = true
);
