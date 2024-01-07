update public.offers
set engine_displacement = regexp_replace(engine_displacement, '[^0-9]', '', 'g');

alter table public.offers
rename column engine_displacement to engine_displacement_cm3;

alter column engine_displacement_cm3 type bigint using engine_displacement_cm3::bigint;