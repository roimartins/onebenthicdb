

Count the number of samples by c-square cell

  -This query result 2 gemoetries. C-square polygon geometry and centroid poitn geometry 

```sql 


drop table public.c_Square_n_samples ; 
create table public.c_Square_n_samples  as 

with aa as ( 
--- select only c-squares form UK EEZ
select * from spatial.c_squares_all_pol_marine_fao_div_eez 
where territory1 = 'United Kingdom') , 

  a as ( 
  ---count smaples by c_square 
  
  select b.c_Square, count(a.*)   , b.geom  
from samples.sample   a ,  aa  b 
where st_intersects ( a.geom, b.geom)   
 group by c_Square , b.geom  ) 
 
 --- join to teh c-squares and calculate centroid 
 select  b.* , a.count  as n_samples  ,
  st_centroid ( b.geom)::geometry(point, 4326 )   as cent_geom 
 from aa b
 left join a
 using (c_square)
 
 --- Update the NULL counts to 0 value
 
 update public.c_Square_n_samples set n_samples = 0 where n_samples IS NULL


```
