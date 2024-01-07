select transmission, count(*) as offers
from public.offers
where transmission is not null
group by transmission
order by count(*) desc;