## 00 Base measures 

1. Summaarne rahastus
```dax
Total Funding = SUM('prod_fact_finance'[expenditure_amount])
```
<br>
<br>

2. Summaarne SKP
```dax
Total GDP = SUM('prod_fact_gdp'[gdp_amount])
```
<br>
<br>

3. Summaarsed tudengid
```dax
Total Students = SUM('prod_fact_education'[student_count])
```
<br>
<br>

## 01 Funding and GDP (Rahastus ja SKP)

1. Keskmine rahastus (Average Funding)
```dax
Avg Annual Funding = 
AVERAGEX(
  VALUES('prod_dim_date'[year]); 
      [Total Funding]
)
```
<br>
<br>

2. Keskmine SKP (Average GDP)
```dax
Avg Annual GDP = 
AVERAGEX(
    VALUES('prod_dim_date'[year]); 
    CALCULATE(
        [Total GDP]; 
        REMOVEFILTERS('prod_dim_sector'); 
        REMOVEFILTERS('prod_dim_isced')
    )
)
```
<br>
<br>

3. Hariduskulude osakaal SKP-st (Kogukulu). Valem on kirjutatud nii, et see ignoreerib sektori ja ISCED-taseme filtreid ainult nimetajas (SKP), tagades korrektse suhtarvu.
```dax
Exp % of GDP = 
VAR TotalExp = [Total Funding]
VAR TotalGDP = 
    CALCULATE(
        [Total GDP];
        REMOVEFILTERS('prod_dim_sector');
        REMOVEFILTERS('prod_dim_isced')
    )
RETURN
    IF(
        NOT ISBLANK(TotalExp) && NOT ISBLANK(TotalGDP) && TotalGDP > 0;
        DIVIDE(TotalExp; TotalGDP);
        BLANK()
    )
```
<br>
<br>

4. Erasektori panus (% SKP-st). Mõõdik näitab, kui palju riigi majandusest liigub kõrgharidusse läbi kodumajapidamiste ja ettevõtete.
```dax
Private Exp % of GDP = 
CALCULATE(
    [Exp % of GDP];
    'prod_dim_sector'[sector_code] = "S1D"
)
```
<br>
<br>

5. Avaliku sektori panus (% SKP-st). Mõõdik isoleerib puhtalt riikliku (maksumaksja) raha osakaalu majanduses.
```dax
Public Exp % of GDP = 
CALCULATE(
    [Exp % of GDP];
    'prod_dim_sector'[sector_code] = "S13"
)
```
<br>
<br>


## 02 Private Higher Education share (Erakõrghariduse osakaal)

1. Keskmised aastesed tudengid
```dax
Avg Annual Students = 
AVERAGEX(
    VALUES('prod_dim_date'[year]); 
    [Total Students]
)
```
<br>
<br>

2. Erarahasastuse määr kõrghariduses
```dax
Private Funding Share % = 
VAR PrivateFund = 
    CALCULATE(
        [Total Funding]; 
        'prod_dim_sector'[sector_group_et] = "Erasektor";
        ALL('prod_dim_sector')
    )
VAR TotalFundAllSectors = 
    CALCULATE(
        [Total Funding]; 
        ALL('prod_dim_sector')
    )
RETURN
    DIVIDE(PrivateFund; TotalFundAllSectors; BLANK())
```
<br>
<br>

3. Erakõrghariduse tudengite määr
```dax
Private Student Share % = 
VAR PrivateStudents = 
    CALCULATE(
        [Total Students]; 
        'prod_dim_sector'[sector_group_et] = "Erasektor";
        ALL('prod_dim_sector')
    )
VAR TotalStudentsAllSectors = 
    CALCULATE(
        [Total Students]; 
        ALL('prod_dim_sector')
```
    )    
RETURN
    DIVIDE(PrivateStudents; TotalStudentsAllSectors; BLANK())
<br>
<br>

## 03 System efficiency (Süsteemi efektiivsus)

1. Hariduskulu ühe tudengi kohta (Eurodes)
```dax
Funding per Student (EUR) = 
VAR AnnualExp = [Total Funding] * 1000000
VAR StudentCount = [Total Students]

RETURN
    IF(
        NOT ISBLANK(AnnualExp) && NOT ISBLANK(StudentCount) && StudentCount > 0;
        DIVIDE(AnnualExp; StudentCount);
        BLANK()
    )
```
<br>
<br>

2. Rahastuse kaal (indeks)
```dax
Funding Weight (Index) = 
DIVIDE(
    [Funding per Student (EUR)]; 
    [GDP per Student (EUR)]; 
    BLANK()
)
```
<br>
<br>

3. SKP tudengi kohta eurodes
```dax
GDP per Student (EUR) = 
VAR AnnualGDP = [Avg Annual GDP] * 1000000
VAR StudentCount = [Total Students]

RETURN
    IF(
        NOT ISBLANK(AnnualGDP) && NOT ISBLANK(StudentCount) && StudentCount > 0;
        DIVIDE(AnnualGDP; StudentCount);
        BLANK()
    )
```
<br>
<br>

## 04 Trendi mõõdikud

1. Rahastuse kasvu indeks
```dax
Funding Growth Index = 
VAR BaseValue = 
    CALCULATE(
        [Total Funding]; 
        'prod_dim_date'[year] = 2013; 
        ALL('prod_dim_date')
    )
RETURN 
    DIVIDE([Total Funding]; BaseValue) * 100
```
<br>
<br>

2. Rahastuse kasvu määr
```dax
Funding Growth Total % = 
VAR Val2013 = CALCULATE([Total Funding]; 'prod_dim_date'[year] = 2013; REMOVEFILTERS('prod_dim_date'))
VAR Val2022 = CALCULATE([Total Funding]; 'prod_dim_date'[year] = 2022; REMOVEFILTERS('prod_dim_date'))
RETURN
DIVIDE(Val2022 - Val2013; Val2013)
```
<br>
<br>

3. Rahastuse määr tudengi kohta
```dax
Funding per Student Growth % = 
VAR Val2013 = CALCULATE([Funding per Student (EUR)]; 'prod_dim_date'[year] = 2013; REMOVEFILTERS('prod_dim_date'))
VAR Val2022 = CALCULATE([Funding per Student (EUR)]; 'prod_dim_date'[year] = 2022; REMOVEFILTERS('prod_dim_date'))
RETURN
DIVIDE(Val2022 - Val2013; Val2013)
```
<br>
<br>

4. SKP kasvuindeks
```dax
GDP Growth Index = 
VAR BaseValue = 
    CALCULATE(
        [Avg Annual GDP]; 
        'prod_dim_date'[year] = 2013; 
        ALL('prod_dim_date')
    )
RETURN 
    DIVIDE([Avg Annual GDP]; BaseValue) * 100
```
<br>
<br>

5. Erarahastuse osakaalu nihe (pp)
```dax
Private Share Shift (pp) = 
VAR Share2013 = CALCULATE([Private Funding Share %]; 'prod_dim_date'[year] = 2013; REMOVEFILTERS('prod_dim_date'))
VAR Share2022 = CALCULATE([Private Funding Share %]; 'prod_dim_date'[year] = 2022; REMOVEFILTERS('prod_dim_date'))
RETURN
Share2022 - Share2013
```
<br>
<br>

6. Tudengite kasvuindeks
```dax
Students Growth Index = 
VAR BaseYear = 2013
VAR BaseValue = 
    CALCULATE(
        [Total Students]; 
        REMOVEFILTERS('prod_dim_date'); 
        'prod_dim_date'[year] = BaseYear
    )
VAR CurrentValue = [Total Students]

RETURN 
    IF(
        NOT ISBLANK(BaseValue) && BaseValue > 0;
        DIVIDE(CurrentValue; BaseValue) * 100;
        BLANK()
    )
```
<br>
<br>

7. Tudengite kasvumäär
```dax
Students Growth Total % = 
VAR Val2013 = CALCULATE([Total Students]; 'prod_dim_date'[year] = 2013; REMOVEFILTERS('prod_dim_date'))
VAR Val2022 = CALCULATE([Total Students]; 'prod_dim_date'[year] = 2022; REMOVEFILTERS('prod_dim_date'))
RETURN
DIVIDE(Val2022 - Val2013; Val2013)
```
