lter table public.offers
add column generation_years text;

update public.offers
set generation_years = '{' || split_part(generation, ' {', 2);

update public.offers
set generation_years = nullif(generation_years, '{');

alter table public.offers
add column generation_start text,
add column generation_end text;

update public.offers
set generation_start = split_part(replace(generation_years, '{', ''), '-', 1),
    generation_end = nullif(split_part(replace(generation_years, '}', ''), '-', 2), '');


alter table public.offers
alter column generation_start type bigint using generation_start::bigint,
alter column generation_end type bigint using generation_end::bigint;

alter table public.offers
drop column generation_years;