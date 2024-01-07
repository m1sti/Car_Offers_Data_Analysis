select transmission, production_year, count(*) as offers
from public.offers
where transmission is not null 
  	and production_year in (
							select production_year
							from public.offers
							group by production_year
							having count(*) >= 10
						   	)
group by transmission, production_year;