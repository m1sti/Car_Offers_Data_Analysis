with bins as (
  select
    floor(mileage_km/10000.00)*10000 as bin_floor,
    count(*) as count
  from public.offers
  where state != 'New'
  group by 1
  order by 1
)

select
  bin_floor,
  bin_floor || ' - ' || (bin_floor + 10000) as bin_range,
  count
from bins
where bin_floor is not null
order by 1;