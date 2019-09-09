# onebenthicdb
SQL code from Vertabelo to create OneBenthicDB

# DATA IMPORT PROCEDURES
## POPULATE TABLES ####
### ADD DATA FROM CSV FILE TO TABLE ####
COPY taxasample FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\tables\table_taxasample.csv' WITH (FORMAT CSV, DELIMITER ',',NULL 'NA', HEADER);

nb/ make sure permission given for everyone and file in .csv format

### DELETE ALL DATA FROM TABLE ####
DELETE FROM tablename

## BRING IN NEW DATA
Start with 'sample' table
#### ADD DATA TO sample TABLE LINE BY LINE ####
notes: data in format '2014-09-27', missing info as NULL, Macrolab 7 (no macro)

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

#### REMOVE RECORD FROM TABLE LINE BY LINE ####
DELETE FROM sample
WHERE samplecode = '0000';
