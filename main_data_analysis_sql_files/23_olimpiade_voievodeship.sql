with brand_ranks as (
    select 
        vehicle_brand, 
        case 
            when rn = 1 then '1st_place'
            when rn = 2 then '2nd_place'
            when rn = 3 then '3rd_place'
        end as rank,
        count(*) as count
    from (
        select 
            voievodeship, 
            vehicle_brand, 
            row_number() over(partition by voievodeship order by count(*) desc) as rn
        from 
            public.offers
        group by 
            voievodeship, 
            vehicle_brand
    ) as subquery
    where rn <= 3
    group by 
        vehicle_brand, 
        rank
)

select 
    vehicle_brand, 
    coalesce(sum(case when rank = '1st_place' then count end), 0) as first_place_count,
    coalesce(sum(case when rank = '2nd_place' then count end), 0) as second_place_count,
    coalesce(sum(case when rank = '3rd_place' then count end), 0) as third_place_count
from 
    brand_ranks
group by 
    vehicle_brand
order by first_place_count desc, second_place_count desc, third_place_count desc;