select fuel_type, count(*)
from public.offers
group by fuel_type
order by count(*) desc;