select count(*) as column_count
from information_schema.columns
where table_name = 'offers';