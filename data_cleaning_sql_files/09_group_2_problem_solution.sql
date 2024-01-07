update public.offers
set    fuel_consumption_in_city = cast (
       regexp_replace(regexp_replace(
                            regexp_replace(
                            fuel_consumption_in_city,
                            '\sl/100km', ''), '\s',
                            '', 'g'), ',', '.') as
       numeric);

alter table public.offers
rename column fuel_consumption_in_city to fuel_consumption_in_city_l_per_100km
;