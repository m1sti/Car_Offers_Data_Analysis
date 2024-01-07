select vehicle_brand, price
from public.offers
where currency = 'PLN' 
	and vehicle_brand in (select vehicle_brand
						from public.offers 
						group by vehicle_brand
					   	order by count(*) desc
					   	limit 20);