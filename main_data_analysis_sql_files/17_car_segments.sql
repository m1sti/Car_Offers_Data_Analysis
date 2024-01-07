with car_brand_median_price as (
    select
        vehicle_brand,
        avg(price),
        percentile_cont(0.5) within group (order by price) as median_price,
		count(*) as vehicle_count
    from public.offers
    group by vehicle_brand
    order by median_price desc
)

select 
	case 
		when median_price > 200001 then 'luxury_brand'
        when median_price between 60000 and 200000 then 'premium_brand'
        when median_price < 60000 then 'mainstream_brand'
        end as segment,
	vehicle_brand,
	vehicle_count
from car_brand_median_price
where vehicle_count > 25
order by median_price desc