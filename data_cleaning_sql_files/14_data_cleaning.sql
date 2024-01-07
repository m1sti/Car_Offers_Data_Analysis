select generation, generation_text, generation_start, generation_end
from public.Offers
where generation is not null
limit 5;