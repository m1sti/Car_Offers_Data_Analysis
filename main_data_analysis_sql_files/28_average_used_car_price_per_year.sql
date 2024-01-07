select production_year, round(avg(price),-2)
from public.offers
where state = 'Used'
group by production_year
having count(*) > 5
order by production_year asc;