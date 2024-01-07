select state, count(*)
from public.offers
group by state
order by count(*) desc;