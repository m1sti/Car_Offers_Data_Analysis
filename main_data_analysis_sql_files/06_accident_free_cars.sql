select no_accident, count(*)
from public.offers
where state = 'Used'
group by no_accident
order by count(*) desc;