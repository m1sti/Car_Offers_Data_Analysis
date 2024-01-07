alter table public.offers
add column generation_text text,

update public.offers
set generation_text = substring(generation from '^(.*) \\(');