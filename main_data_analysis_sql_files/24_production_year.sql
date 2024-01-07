select production_year, count(*)
from public.offers
group by production_year
order by production_year asc;