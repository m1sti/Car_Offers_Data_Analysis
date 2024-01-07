with brand_counts as (
    select 
        voievodeship, 
        vehicle_brand, 
        count(*) as brand_count
    from 
        public.offers
    group by 
        voievodeship, 
        vehicle_brand
),
ranked_brands as (
    select 
        voievodeship, 
        vehicle_brand, 
        brand_count,
        row_number() over(partition by voievodeship order by brand_count desc) as rn
    from 
        brand_counts
)

select 
    voievodeship, 
    max(case when rn = 1 then vehicle_brand end) as top1_vehicle_brand,
    max(case when rn = 2 then vehicle_brand end) as top2_vehicle_brand,
    max(case when rn = 3 then vehicle_brand end) as top3_vehicle_brand
from 
    ranked_brands
where voievodeship is not null
group by voievodeship;