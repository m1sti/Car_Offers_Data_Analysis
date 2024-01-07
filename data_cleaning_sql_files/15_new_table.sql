create table public.location(
 poviat text
,poviat_main_city text
,voivodeship text
,area_km2 text
,count_of_people numeric
,population_density numeric
);

copy public.location 
from '/Users/m1sti/Downloads/location.csv' delimiter ',' csv header;