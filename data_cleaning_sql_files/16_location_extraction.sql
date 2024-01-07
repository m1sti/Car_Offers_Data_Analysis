alter table public.offers
add column powiat varchar(255);

update public.offers
set powiat = (
  select poviat
  from public.location
  where public.offers.location ilike '%' || poviat || '%'
  limit 1
);

update public.offers
set voievodeship = public.location.voivodeship
from public.location
where public.offers.powiat = public.location.poviat
  and public.offers.voievodeship is null
  and public.offers.powiat is not null;

alter table public.offers
drop column location_voivodeship;