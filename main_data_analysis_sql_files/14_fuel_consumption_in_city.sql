with bins as (
  select
    case 
      when floor(fuel_consumption_in_city_l_per_100km/1.00)*1 > 25 then '>25'
      else cast(floor(fuel_consumption_in_city_l_per_100km/1.00)*1 as text)
    end as bin_floor,
    count(*) as count
from public.offers
group by 1
order by 1
)

select 
  bin_floor,
  case 
    when bin_floor = '>25' then bin_floor 
    else bin_floor || ' - ' || (cast(bin_floor as integer) + 1) 
  end as bin_range,
 count
from bins 
where bin_floor is not null and bin_floor != 'null'
order by case 
			when bin_floor = '>25' then null 
			else cast(bin_floor as integer) 
			end;