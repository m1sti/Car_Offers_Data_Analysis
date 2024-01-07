select 	production_year, 
		percentile_cont(0.5) within group (order by mileage_km) as median_mileage
from public.offers
group by production_year
having count(*) > 10
order by production_year desc;