 select vehicle_brand, count(*) as brand_count
 from public.offers
 group by vehicle_brand
 order by brand_count desc;