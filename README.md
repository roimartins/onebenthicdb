# onebenthicdb
SQL code from Vertabelo to create OneBenthicDB

# BACKUP THE DB
RMC on database in PGAdmin4>Backup...>Enter filepath and filename 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\BACKUP\OneBenthic'>Press Backup button.

# CREATE A COPY OF DB FOR TESTING/RESTORE
Create DB in PGAmin4>RMC on db, select 'Restore'> select file 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\BACKUP\OneBenthic'> Press Restore button.

# CHANGES TO DB STRUCTURE (IN PG ADMIN)
Table 'taxasample' col 'taxa_taxaqual_qualifier' changed from Not NULL? Yes to Not NULL? No

# USEFUL CODE FOR QUERYING
Use LIKE and % where items begings with
select * from sample where samplecode LIKE 'RSMP_SC%'

To delete/update records within a column use:
UPDATE taxasample SET taxa_taxaqual_qualifier = NULL 
WHERE taxa_taxaqual_qualifier = 'A';
This code gets rid of A's in col 'taxa_taxaqual_qualifier' in table 'taxasample'

# DATA ISSUES WHICH NEED TO BE RESOLVED
1. SC RSMP FAUNAL SAMPLES: PSA FOR <63um is split across all sieves. should be a total under 0mm siever. Has been resolved for PSA only samples. Problem also for new Baseline East Channel benthic samples. ISSUE RESOLVED 11/09/2019
2. Add sediment only samples from East Channel baseline (2014/15), BC and NW. I checked and there re no sed only samples for the east channel.

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
NB Last id used was 34348
COPY sample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sample humber baseline psa only.csv' DELIMITER ','NULL AS '[null]'  CSV HEADER;

### ADD DATA TO sedvarsample TABLE USING CSV IMPORT
NB Last id used was 668858 (after import)
COPY sedvarsample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sedvarsample humber baseline psa only.csv' DELIMITER ','  CSV HEADER;

ADD DATA TO survey TABLE
NB you can’t add data into table surveysample until there survey is there
INSERT INTO survey (surveyname, programme, surveypurpose, datapubliclyavailable, data)VALUES('Anglian Regional Seabed Monitoring Programme 2018','RSMP','Monitoring',FALSE,'N')

3. Enter data into table 'surveysample'
### ADD DATA to table surveysample
NB Last id used was 35158 (after import)
COPY surveysample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update surveysample humber baseline psa only.csv' DELIMITER ',' CSV HEADER;

Make sure any new stations are added:
INSERT INTO station(stationcode,stationlong,stationlat,stationnotes,stationsubgroup2,stationsubgroup1,	stationgroup) VALUES
('A_0870',2.286766, 52.42388,NULL,NULL,'Anglian RSMP','RSMP'),
('A_0871',2.255853,52.483941,NULL,NULL,'Anglian RSMP','RSMP'),
('A_0872',1.990628,52.787012,NULL,NULL,'Anglian RSMP','RSMP'),
('A_0873',2.130847,52.202034,NULL,NULL,'Anglian RSMP','RSMP');


4. Enter data into table 'samplestation'
NB Last id used was 5519 (after import)
COPY samplestation FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update samplestation humber baseline psa only.csv' DELIMITER ',' CSV HEADER;

5. Enter data into table 'sampleowner'
NB Last id used was 35158 (after import)
COPY sampleowner FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sampleowner humber baseline psa only.csv' DELIMITER ',' CSV HEADER;

## TO REPLACE ERRONEOUS RECORDS FROM TABLE sedvarsample

# First remove incorrect records using code:
DELETE FROM sedvarsample
WHERE 
sample_samplecode = 'RSMP_EC_0001_Baseline' OR
sample_samplecode = 'RSMP_EC_0002_Baseline' OR
sample_samplecode = 'RSMP_EC_0003_Baseline';

then add correct data in normal way. Eg.
COPY sedvarsample
FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\table update sedvarsample humber baseline psa only.csv' DELIMITER ','  CSV HEADER;

6. Enter data into table 'taxasample'
Start by getting taxon abundance matrix into correct format:
- Ensure samplecodes match those in the sample table
- Rename col 1 'samplecode' This col contains the taxon names (this is not a mistake)
- Rename col 2 'qualifier'
- Replace 'P' with '1'
- Insert 'NA' to blank cells
Save file as A2018benshort.csv
Use 'get_abund_data_into_long_format.R' to change data into long format. This results in a file 'A2018abundlong.csv'
Open 'A2018abundlong.csv' and insert col for 'id' and 'biomass'. If no biomass data enter [null]. NB Last id used was 1225216 (after import) 

COPY taxasample FROM 'C:\Users\kmc00\OneDrive - CEFAS\OneBenthicDB\RSMP PSA ONLY STATIONS\A2018abundlong.csv' DELIMITER ',' CSV HEADER;



NB/ If any taxa are missing from table'taxa' then these will need to be entered manually using code:
INSERT INTO faunal_data.taxa(taxonname,countable,aphiaID,matchtype,lsid,tsn,qualitystatus,taxonstatus,scientificname,authority,aphiaidaccepted,scientificnameaccepted,authorityaccepted,kingdom,phylum,"class","order","family",genus,subgenus,species,subspecies,ismarine,isbrackish,isfresh,isterrestrial,citation,taxonnotes,include,nonnative,conservationimportance,taxaqual_qualifier)
VALUES('Aoridae (female)',true,101368,'exact','urn:lsid:marinespecies.org:taxname:101368',93440,'Checked by Taxonomic Editor','accepted','Aoridae','Stebbing, 1899',101368,'Aoridae','Stebbing, 1899','Animalia','Arthropoda','Malacostraca','Amphipoda','Aoridae','Aoridae','Aoridae',NULL,NULL,true,NULL,NULL,NULL,'Horton, T.; De Broyer, C. (2015). Aoridae Stebbing, 1899. In: Horton, T.; Lowry, J.; De Broyer, C.; Bellan-Santini, D.; Coleman, C. O.; Daneliya, M.; Dauvin, J-C.; Fiser, C.; Gasca, R.; Grabowski, M.; Guerra-Garcia, J. M.; Hendrycks, E.; Holsinger, J.; Hughes, L.; Jazdzewski, K.; Just, J.; Kamaltynov, R. M.; Kim, Y.-H.; King, R.; Krapp-Schickel, T.; LeCroy, S.; Lorz, A.-N.; Senna, A. R.; Serejo, C.; Sket, B.; Thomas, J.; Thurston, M.; Vader, W.; Vainola, R.; Vonk, R.; White, K.; Zeidler, W. World Amphipoda Database. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=101368 on 2015-10-06',NULL,true,false,false,'F')



# QUERING MULTIPLE TABLES (INNER JOIN)
https://www.youtube.com/watch?v=7h9uuILngp0

select samplecode,samplelat, samplelong,station_stationcode,stationlong,stationlat,baselinefaunalcluster_faunalcluster
FROM sample, samplestation,station,cluster
where sample.samplecode=samplestation.sample_samplecode
AND samplestation.station_stationcode=station.stationcode
AND sample.samplecode=cluster.sample_samplecode
and station_stationcode like 'SC_%'
ORDER BY station_stationcode;

## Output abund data at family level
SELECT sample_samplecode,family,abund,samplelat,samplelong
FROM taxasample,faunal_data.taxa ,sample
WHERE
 taxasample.taxa_taxonname=faunal_data.taxa.taxonname
AND
taxasample.taxa_taxaqual_qualifier=faunal_data.taxa.taxaqual_qualifier
AND sample_samplecode like 'RSMP%_2018'
AND sample.samplecode = taxasample.sample_samplecode
ORDER BY sample_samplecode;


## Output abund data at 'scientificnameaccepted' level
SELECT sample_samplecode,scientificnameaccepted,abund,samplelat,samplelong
FROM taxasample,faunal_data.taxa ,sample
WHERE
 taxasample.taxa_taxonname=faunal_data.taxa.taxonname
AND
taxasample.taxa_taxaqual_qualifier=faunal_data.taxa.taxaqual_qualifier
AND sample_samplecode like 'RSMP%_2018'
AND sample.samplecode = taxasample.sample_samplecode
ORDER BY sample_samplecode;
