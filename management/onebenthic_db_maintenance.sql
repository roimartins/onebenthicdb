--- ADD MPA VALUES TO THE SAMPLE.SAMPLES TABLE 

select * from samples.sample  where mpa_id is null limit 100; 


alter table samples.sample add column mpa_id varchar(250 ) ; 


update samples.sample a set in_mpa =  true, mpa_id = site_code from anthropogenic.c20180927_offshore_mpas_wgs84 b where st_intersects(a.geom, b.geom) ; 
update samples.sample a set in_mpa =  false where in_mpa IS NULL;  

-- add mpas from other dataset ( Selected for the monitoring addded value project) 
update samples.sample a set in_mpa =  false  , mpa_id = NULL  from anthropogenic.mpa_areas_selected_added_monitoring  b  where in_mpa IS true and st_intersects(a.geom, b.geom) ; 


select  st_srid(geom) from anthropogenic.mpa_areas_selected_added_monitoring  



---- adding a new column into associtions.station table lto define if tehy are "active" ( 19/11/2019) 

ALTER TABLE associations.station   ADD COLUMN active boolean NOT NULL DEFAULT TRUE; 
