select body_type, count(*)
from public.offers
group by body_type
order by count(*) desc;