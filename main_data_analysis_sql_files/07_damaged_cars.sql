select damaged, count(*)
from public.offers
where state = 'Used' and no_accident is false
group by damaged
order by count(*) desc;