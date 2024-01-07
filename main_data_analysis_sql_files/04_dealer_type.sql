select seller_type, count(*)
from public.offers
group by seller_type
order by count(*) desc;