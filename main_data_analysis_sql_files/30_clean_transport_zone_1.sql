with clean_transport_zone as (
    select
        id,
        fuel_type,
        production_year,
        voievodeship,
        price,
		damaged,
		currency,
        case
            when fuel_type = 'Diesel' and production_year < 2010 then false
            when fuel_type in ('Gasoline', 'Gasoline + CNG', 'Gasoline + LPG') and production_year < 2000 then false
            else true
        end meets_ctz_requirements
    from public.offers
)

select
    count(*) as total_count,
    count(*) filter (where meets_ctz_requirements) as meets_ctz_count,
    round((count(*) filter (where meets_ctz_requirements)::numeric / count(*)) * 100,1) as percentage
from clean_transport_zone 
where damaged is false and voievodeship = 'Małopolskie' and currency = 'PLN' and production_year > 1985;