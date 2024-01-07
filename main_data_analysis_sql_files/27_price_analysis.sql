with bins as (
  select
    case 
      when floor(price/5000.00)*5000 > 500000 then '>500000'
      else cast(floor(price/5000.00)*5000 as text)
    end as bin_floor,
    count(*) as count
from public.offers
where currency = 'PLN'
group by 1
order by 1
)

select 
  bin_floor,
  case 
    when bin_floor = '>500000' then bin_floor 
    else bin_floor || ' - ' || (cast(bin_floor as integer) + 5000) 
  end as bin_range,
count
from bins where bin_floor is not null 
	and bin_floor != 'null'
order by case 
			 when bin_floor = '>500000' then null 
			 else cast(bin_floor as integer) 
			 end;