with car_brand_median_price as (
    select
        vehicle_brand,
        avg(price),
        percentile_cont(0.5) within group (order by price) as median_price
    from public.offers
    group by vehicle_brand
    order by median_price desc
),
car_brand_segmentation as (
    select 
        vehicle_brand,
        median_price,
        case 
            when median_price > 200001 then 'luxury_brand'
            when median_price between 60000 and 200000 then 'premium_brand'
            when median_price < 60000 then 'mainstream_brand'
        end as segment
    from car_brand_median_price
    order by median_price desc
)

select
    cbs.segment,
    case
        when color in ('Yellow', 'Green', 'Red', 'Blue', 'Orange', 'Purple', 'Sky Blue', 'Navy Blue', 'Burgundy') then 'Vibrant Colors'
        when color in ('Gray', 'Silver', 'Black', 'White') then 'Monochromatic Colors'
    end as color_group,
    round(count(*) * 100.0 / sum(count(*)) over (partition by cbs.segment),1) as percentage
from
    public.offers as of
inner join car_brand_segmentation as cbs
    on of.vehicle_brand = cbs.vehicle_brand
where
    color is not null
    and (color in ('Yellow', 'Green', 'Red', 'Blue', 'Orange', 'Purple', 'Sky Blue', 'Navy Blue', 'Burgundy')
        or color in ('Gray', 'Silver', 'Black', 'White'))
group by
    cbs.segment, color_group
order by
    cbs.segment, count(*) desc;