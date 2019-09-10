# onebenthicdb
SQL code from Vertabelo to create OneBenthicDB

# CHANGES TO DB STRUCTURE (IN PG ADMIN)



# DATA IMPORT PROCEDURES
## POPULATE TABLES ####
### ADD DATA FROM CSV FILE TO TABLE ####
COPY taxasample FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\tables\table_taxasample.csv' WITH (FORMAT CSV, DELIMITER ',',NULL 'NA', HEADER);

nb/ make sure permission given for everyone and file in .csv format

### DELETE ALL DATA FROM TABLE
DELETE FROM tablename

## BRING IN NEW DATA
1. Start with 'sample' table

### ADD DATA TO sample TABLE LINE BY LINE
Notes:
Date needs to be in format:'2014-09-27',
Missing info as NULL, 
If no macro data use macroprocessinglab_id = 7 (no macro).


INSERT INTO sample (
id,
samplecode,	
samplelat,	
samplelong,	
waterdepth,	
year,	
month,	
date,	
grabsamplesize,	
macrosieve,
samplecode2,
psasubsample,	
samplenotes,	
treatment,	
inccol,	
samplephotowhole,	
samplephotoresidue,	
gear_gearcode,	
baselinesample,	
psaprocessinglab_id,	
macroprocessinglab_id)

VALUES(
33199,
'RSMP_H_0001_Baseline',
53.394505,
0.528082,
13,
2014,
9,
'2014-09-27,
5,
1,
NULL,
TRUE,
NULL,
NULL,
NULL,
NULL,
NULL,
'MHN',
FALSE,
2,
7);

### REMOVE RECORD FROM TABLE LINE BY LINE ####
DELETE FROM sample
WHERE samplecode = 'RSMP_H_0001_Baseline';

2. Enter sed data into table 'sedvarsample'

NB/ only enter data where sieve has been used (i.e. ignore NAs/NULL)

INSERT INTO sedvarsample (id,sample_samplecode,sedvar_sievesize,percentage) VALUES

(606677,'RSMP_H_0001_Baseline',	'63',	0),
(606678,'RSMP_H_0001_Baseline',	'45',	0),
(606679,'RSMP_H_0001_Baseline',	'31.5',	0),
(606680,'RSMP_H_0001_Baseline',	'22.4',	1.300148588),
(606681,'RSMP_H_0001_Baseline',	'16',	4.439078752),
(606682,'RSMP_H_0001_Baseline',	'11.2',	5.206785537),
(606683,'RSMP_H_0001_Baseline',	'8',	6.141654284),
(606684,'RSMP_H_0001_Baseline',	'5.6',	6.773155027),
(606685,'RSMP_H_0001_Baseline',	'4',	6.129271917),
(606686,'RSMP_H_0001_Baseline',	'2.8',	7.317979198),
(606687,'RSMP_H_0001_Baseline',	'2',	4.84769688),
(606688,'RSMP_H_0001_Baseline',	'1.4',	3.293709757),
(606689,'RSMP_H_0001_Baseline',	'1',	2.526002972),
(606690,'RSMP_H_0001_Baseline',	'0.71',	1.931649331),
(606691,'RSMP_H_0001_Baseline',	'0.5',	2.40837048),
(606692,'RSMP_H_0001_Baseline',	'0.355',	3.436106984),
(606693,'RSMP_H_0001_Baseline',	'0.25',	12.22758791),
(606694,'RSMP_H_0001_Baseline',	'0.18',	18.07206538),
(606695,'RSMP_H_0001_Baseline',	'0.125',	7.75136206),
(606696,'RSMP_H_0001_Baseline',	'0.09',	1.312530956),
(606697,'RSMP_H_0001_Baseline',	'0.063',	0.755324418),
(606698,'RSMP_H_0001_Baseline',	'0',	4.129519564);

### ADD DATA TO sample TABLE USING CSV IMPORT
NB Last id used was 33588
COPY sample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sample humber baseline psa only.csv' DELIMITER ','NULL AS '[null]'  CSV HEADER;

### ADD DATA TO sedvarsample TABLE USING CSV IMPORT
NB Last id used was 616579 (after import)
COPY sedvarsample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sedvarsample humber baseline psa only.csv' DELIMITER ','  CSV HEADER;

3. Enter data into table 'surveysample'
### ADD DATA to table surveysample
NB Last id used was 33588 (after import)
COPY surveysample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update surveysample humber baseline psa only.csv' DELIMITER ',' CSV HEADER;


4. Enter data into table 'samplestation'
NB Last id used was 3949 (after import)
COPY samplestation FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update samplestation humber baseline psa only.csv' DELIMITER ',' CSV HEADER;

5. Enter data into table 'sampleowner'
NB Last id used was 33588 (after import)
COPY sampleowner FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sampleowner humber baseline psa only.csv' DELIMITER ',' CSV HEADER;
