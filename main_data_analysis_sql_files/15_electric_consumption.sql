with bins as (
  select
  floor(average_consumption_kwh_per_100km/1.00)*1 as bin_floor,
  count(*) as count
from public.offers
where fuel_type = 'Electric'
group by 1
order by 1
)
select
  bin_floor,
  bin_floor || ' - ' || (bin_floor + 1) as bin_range,
  count
from bins
where bin_floor is not null
order by 1;