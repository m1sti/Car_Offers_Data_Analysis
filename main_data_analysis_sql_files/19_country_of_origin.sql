select country_of_origin, count(*)
from public.offers
where state = 'Used' and country_of_origin is not null and country_of_origin <> 'Poland'
group by country_of_origin
order by count(*) desc;