-- SKP toorandmete laadimine Google Cloud Storage bucketist
LOAD DATA OVERWRITE `optimal-cogency-483908-t3.kursusetoo_korghariduse_analyys.land_gdp`
FROM FILES (
  format = 'CSV',
  uris = ['gs://kursusetoo/estat_nama_10_gdp.tsv'],
  field_delimiter = '\t',
  skip_leading_rows = 1,
  allow_jagged_rows = true
);
