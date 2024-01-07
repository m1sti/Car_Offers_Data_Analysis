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
    case
        when price between 0 and 5000 then '0-5k'
        when price between 5001 and 10000 then '5-10k'
        when price between 10001 and 15000 then '10-15k'
        when price between 15001 and 20000 then '15-20k'
        when price between 20001 and 25000 then '20-25k'
		when price between 25001 and 30000 then '25-30k'
		when price between 30001 and 35000 then '30-35k'
		when price between 35001 and 40000 then '35-40k'
		when price between 40001 and 45000 then '40-45k'
		when price between 45001 and 50000 then '45-50k'
        else 'more than 50k'
    end as price_group,
    count(*) as total_count,
    count(*) filter (where meets_ctz_requirements) as meets_ctz_count,
    round(count(*) filter (where meets_ctz_requirements)::numeric / count(*)) * 100,2) as percentage
from clean_transport_zone 
where damaged is false and voievodeship = 'Małopolskie' and currency = 'PLN' and production_year > 1985
group by price_group
order by price_group asc;