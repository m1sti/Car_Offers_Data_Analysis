alter table public.offers
add column first_registration_date date;

set first_registration_date = to_date(date_of_first_registration_in_vehicle_history, 'DD/MM/YYYY');

alter table public.offers
drop column date_of_first_registration_in_vehicle_history;