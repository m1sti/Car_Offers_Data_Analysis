select
  body_type,
  production_year,
  count(*) as count
from public.offers
where production_year >= 1990
group by body_type, production_year
order by body_type, production_year desc;