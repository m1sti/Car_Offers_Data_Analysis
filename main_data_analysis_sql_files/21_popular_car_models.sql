select vehicle_brand, vehicle_model, count(*)
from public.offers
group by vehicle_brand, vehicle_model
order by count(*) desc
limit 10;