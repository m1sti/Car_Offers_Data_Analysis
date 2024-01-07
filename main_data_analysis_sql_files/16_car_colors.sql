select 	
	case
		when color in ('beige', 'brown') then 'beige/brown'
		when color in ('black') then 'black'
		when color in ('gray') then 'gray'
		when color in ('silver') then 'silver'
		when color in ('blue', 'navy blue', 'sky blue') then 'blue'
		when color in ('burgundy', 'red') then 'red'
		when color in ('golden', 'yellow') then 'golden/yellow'
		when color = 'green' then 'green'
		when color = 'orange' then 'orange'
		when color = 'purple' then 'other'
		when color = 'white' then 'white'
		else 'other'
		end as color_group,
	production_year,
	count(*) as count
from public.offers
where production_year >= 1990
group by color_group, production_year
order by count desc;