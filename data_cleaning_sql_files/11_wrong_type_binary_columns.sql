update public.offers
set no_accident = case when no_accident = 'Tak' then 'true' else 'false' end;

alter table public.offers
add column no_accident_bool boolean;

update public.offers
set no_accident_bool = (no_accident = 'true')::boolean,

alter table public.offers
drop column no_accident,
rename column no_accident_bool to no_accident;