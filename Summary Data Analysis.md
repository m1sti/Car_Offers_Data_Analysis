# Summary Data Analysis

## Table of contents

 #### 1. Introduction
 #### 2. 
 #### 3. 
 3.1. 
 #### 4. Summary

## Introduction

W Data Preparation I Cleaning dane ofert sprzedaży z Otomoto zostały wyczyszczone i przygotowane do analizy. 

Zacznijmy od przedstawienia tabeli Offers: 
``` sql
select count(*) as row_count
from public.offers;
```
| row_count |
| ------------- |
| 208186|

``` sql
select count(*) as column_count
from information_schema.columns
where table_name = 'offers';
```
| column_count |
| ------ |
| 44     |

Tabela offers ma 44 kolumny I 208 186 pozycji.   

``` sql
select *
from public.offers
limit 5;
```

| id         | offer_creation_date | offer_title                           | price  | currency | seller_type       | location                                                  | vehicle_brand | vehicle_model  | generation     | production_year | mileage_km | engine_displacement_cm3 | fuel_type | power_km | transmission | body_type     | number_of_doors | number_of_seats | color    | state | version                  | country_of_origin | fuel_consumption_in_city_l_per_100km | average_consumption_kwh_per_100km | color_type | drive_type                   | manufacturers_warranty_period | rear_distance_control_when_parking | distance_control_in_front_when_parking | rear_parking_camera | apple_carplay | android_auto | first_registration_date | registered_in_poland | first_owner_from_new | no_accident | damaged | tuning | generation_text | generation_start | generation_end | voievodeship  | powiat   |
| ---------- | ------------------- | ------------------------------------- | ------ | -------- | ----------------- | --------------------------------------------------------- | ------------- | -------------- | -------------- | --------------- | ---------- | ----------------------- | --------- | -------- | ------------ | ------------- | --------------- | --------------- | -------- | ----- | ------------------------ | ----------------- | ------------------------------------ | --------------------------------- | ---------- | ---------------------------- | ----------------------------- | ---------------------------------- | -------------------------------------- | ------------------- | ------------- | ------------ | ----------------------- | -------------------- | -------------------- | ----------- | ------- | ------ | --------------- | ---------------- | -------------- | ------------- | -------- |
| 6104602148 | 2023-04-22 16:40:00 | Ford Mustang Mach-E                   | 408000 | PLN      | Authorized Dealer | Brzezińska 26 - 92-103 Łódź, Widzew (Polska)              | Ford          | Mustang Mach-E |                | 2022            | 5          |                         | Electric  | 487      | Automatic    | SUV           | 5               | 5               | White    | New   |                          | Poland            |                                      | 20                                | Metallic   | 4x4 (fixed)                  |                               | TRUE                               | TRUE                                   | TRUE                | TRUE          | TRUE         |                         | FALSE                | FALSE                | TRUE        | FALSE   | FALSE  |                 |                  |                | Łódzkie       | Łódź     |
| 6109052400 | 2023-04-22 10:24:00 | Volvo XC 60                           | 159900 | PLN      | Authorized Dealer | ul. Kaliska 26 - 61-315 Poznań, Nowe Miasto (Polska)      | Volvo         | XC 60          | II {2017-}     | 2018            | 162000     | 19693                   | Gasoline  | 310      | Automatic    | SUV           | 5               | 5               | Black    | Used  |                          | Poland            |                                      |                                   |            | 4x4 (attached automatically) |                               | TRUE                               | TRUE                                   | TRUE                | TRUE          | TRUE         | 2018-04-18              | TRUE                 | TRUE                 | TRUE        | FALSE   | FALSE  | II              | 2017             |                | Wielkopolskie | Poznań   |
| 6108805876 | 2023-04-22 14:55:00 | Skoda Superb 2.0 TDI 4x4 Ambition DSG | 99900  | PLN      | Authorized Dealer | Połczyńska 125 - 01-303 Warszawa, Bemowo (Polska)         | Skoda         | Superb         | III {2015-}    | 2018            | 121494     | 19683                   | Diesel    | 190      | Automatic    | Station wagon | 5               | 5               | White    | Used  | 2.0 TDI 4x4 Ambition DSG | Germany           |                                      |                                   |            | 4x4 (attached automatically) |                               | TRUE                               | TRUE                                   | FALSE               | TRUE          | TRUE         | 2018-11-15              | TRUE                 | FALSE                | TRUE        | FALSE   | FALSE  | III             | 2015             |                | Mazowieckie   | Warszawa |
| 6108520934 | 2023-04-20 12:47:00 | Volkswagen Touran                     | 25900  | PLN      | Dealer            | Seleny 75, Gdańsk, Polska - 80-299 Gdańsk, Osowa (Polska) | Volkswagen    | Touran         | I {2003-2010}  | 2008            | 181000     | 19683                   | Diesel    | 140      | Manual       | Minivan       | 4               | 5               | Gray     | Used  |                          |                   |                                      |                                   | Metallic   | Front wheels                 |                               | TRUE                               | FALSE                                  | FALSE               | FALSE         | FALSE        |                         | FALSE                | TRUE                 | TRUE        | FALSE   | FALSE  | I               | 2003             | 2010           | Pomorskie     | Gdańsk   |
| 6108924858 | 2023-04-17 14:58:00 | Fiat Panda 1.2 Automatik Emotion      | 11900  | PLN      | Dealer            | Płochocińska 262 - 03-044 Warszawa, Białołęka (Polska)    | Fiat          | Panda          | II {2003-2012} | 2004            | 181200     | 12423                   | Gasoline  | 60       | Automatic    | Compact       | 5               | 5               | Burgundy | Used  | 1.2 Automatik Emotion    | Germany           | 6.80                                 |                                   | Metallic   | Front wheels                 |                               | FALSE                              | FALSE                                  | FALSE               | FALSE         | FALSE        | 2004-08-03              | TRUE                 | FALSE                | TRUE        | FALSE   | FALSE  | II              | 2003             | 2012           | Mazowieckie   | Warszawa |

``` sql
-- Ten kod zwraca nazwy kolumn i ich typy danych dla tabeli "offers".
select column_name, data_type
from information_schema.columns
where table_name = 'offers';
```


``` sql
-- Ten kod zwraca typy sprzedawców i ich liczebność w tabeli "public.offers", posortowane malejąco.
select seller_type, count(*)
from public.offers
group by seller_type
order by count(*) desc;
```

``` sql
-- Ten kod zwraca stany pojazdów i ich liczebność w tabeli "public.offers", posortowane malejąco.
select state, count(*)
from public.offers
group by state
order by count(*) desc;

-- opis: otomoto to portal na którym użytkownicy w przeważającej 
-- wielkości wystawiają samochody używane, około co 10 
-- oferta to nowy samochód
```

``` sql
-- Ten kod zwraca typy nadwozi i ich liczebność w tabeli "public.offers", posortowane malejąco.
select body_type, count(*)
from public.offers
group by body_type
order by count(*) desc;
```

``` sql
-- Ten kod zwraca typy paliwa i ich liczebność w tabeli "public.offers", posortowane malejąco.
select fuel_type, count(*)
from public.offers
group by fuel_type
order by count(*) desc;
```

``` sql
-- Ten kod zwraca informacje o tym, czy pojazdy były zaangażowane w wypadki, i ich liczebność w tabeli "public.offers", tylko dla używanych pojazdów, posortowane malejąco.
select no_accident, count(*)
from public.offers
where state = 'Used'
group by no_accident
order by count(*) desc;
```

``` sql
-- Ten kod zwraca informacje o tym, czy pojazdy były uszkodzone, i ich liczebność w tabeli "public.offers", tylko dla używanych pojazdów, które były zaangażowane w wypadki, posortowane malejąco.
select damaged, count(*)
from public.offers
where state = 'Used' and no_accident is false
group by damaged
order by count(*) desc;
```

``` sql
-- Ten kod zwraca 20 najpopularniejszych marek pojazdów i ich liczebność w tabeli "public.offers", a także sumę pozostałych marek jako "Other".

-- Wybieranie 20 najpopularniejszych marek pojazdów
with top_20 as (
  select vehicle_brand, count(*) as brand_count
  from public.offers
  group by vehicle_brand
  order by brand_count desc
  limit 20
)

-- Wybieranie pozostałych marek pojazdów
, rest as (
  select vehicle_brand, count(*) as brand_count
  from public.offers
  where vehicle_brand not in (select vehicle_brand from top_20)
  group by vehicle_brand
)

-- Łączenie wyników
select vehicle_brand, brand_count
from top_20
union all
select 'Other' as vehicle_brand, sum(brand_count) as brand_count
from rest;
```

``` sql
-- Ten kod zwraca 10 najpopularniejszych kombinacji marek i modeli pojazdów i ich liczebność w tabeli "public.offers".
select vehicle_brand, vehicle_model, count(*)
from public.offers
group by vehicle_brand, vehicle_model
order by count(*) desc
limit 10;
```

``` sql
-- Ten kod zwraca rok produkcji pojazdów i ich liczebność w tabeli "public.offers", posortowane rosnąco.
select production_year, count(*)
from public.offers
group by production_year
order by production_year asc;
```

``` sql
-- Ten kod tworzy przedziały dla przebiegu pojazdów (co 10 000 km) i zwraca liczbę pojazdów w każdym przedziale.
with bins as (
  select
  floor(mileage_km/10000.00)*10000 as bin_floor,
  count(*) as count
from public.offers
group by 1
order by 1
)
select
  bin_floor,
  bin_floor || ' - ' || (bin_floor + 10000) as bin_range,
  count
from bins
where bin_floor is not null
order by 1;
```

``` sql
-- Ten kod tworzy przedziały dla cen pojazdów (co 2000) i zwraca liczbę pojazdów w każdym przedziale.
with bins as (
  select
    case 
      when floor(price/5000.00)*5000 > 750000 then '>750000'
      else cast(floor(price/5000.00)*5000 as text)
    end as bin_floor,
    count(*) as count
from public.offers
group by 1
order by 1
)

select 
  bin_floor,
  case 
    when bin_floor = '>750000' then bin_floor 
    else bin_floor || ' - ' || (cast(bin_floor as integer) + 5000) 
  end as bin_range,
count
from bins where bin_floor is not null and bin_floor != 'null'
order by case when bin_floor = '>750000' then null else cast(bin_floor as integer) end;
```

``` sql
-- Ten kod tworzy przedziały dla średniego spalania pojazdów (co 1 l/100km) i zwraca liczbę pojazdów w każdym przedziale.
with bins as (
  select
    case 
      when floor(fuel_consumption_in_city_l_per_100km/1.00)*1 > 25 then '>25'
      else cast(floor(fuel_consumption_in_city_l_per_100km/1.00)*1 as text)
    end as bin_floor,
    count(*) as count
from public.offers
group by 1
order by 1
)
select 
  bin_floor,
  case 
    when bin_floor = '>25' then bin_floor 
    else bin_floor || ' - ' || (cast(bin_floor as integer) + 1) 
  end as bin_range,
count
from bins where bin_floor is not null and bin_floor != 'null'
order by case when bin_floor = '>25' then null else cast(bin_floor as integer) end;
```

``` sql
-- Ten kod zwraca kraje pochodzenia używanych pojazdów (z wyjątkiem Polski) i liczbę pojazdów z każdego kraju.
select country_of_origin, count(*)
from public.offers
where state = 'Used' and country_of_origin is not null and country_of_origin <> 'Poland'
group by country_of_origin
order by count(*) desc;
```

``` sql
-- Ten kod zwraca średnie ceny dla 30 najpopularniejszych marek pojazdów (z co najmniej 10 ofertami) w tabeli "public.offers".
select vehicle_brand, round(avg(price),-2) as avg_price
from public.offers
where vehicle_brand in (select vehicle_brand
						from public.offers 
						group by vehicle_brand
					   	order by count(*) desc
					   	limit 30)
group by vehicle_brand
having count(*) > 10
order by avg(price) desc;
```

``` sql
-- Ten kod zwraca średnią cenę używanych pojazdów dla każdego roku produkcji (z co najmniej 5 ofertami), posortowane rosnąco według roku produkcji.
select production_year, round(avg(price),-2)
from public.offers
where state = 'Used'
group by production_year
having count(*) > 5
order by production_year asc;
```
``` sql
-- Ten kod zwraca marki pojazdów i liczbę ofert dla każdej marki w tabeli "public.offers", posortowane malejąco.
select vehicle_brand, count(*) as offers
from public.offers
group by vehicle_brand
order by count(*) desc;
```

``` sql
-- Ten kod zwraca typy sprzedawców (osoby prywatne lub dealerzy) i liczbę ofert dla każdego typu w tabeli "public.offers", posortowane malejąco.
select
	case 
		when seller_type = 'Private person' then 'Private person'
		else 'Dealer'
	end seller, 
	count(*) as count
from public.offers
group by seller
order by count(*) desc;
```

``` sql
-- Ten kod zwraca typy paliwa i liczbę ofert dla każdego typu w tabeli "public.offers", posortowane malejąco.
select fuel_type, count(*) as offers
from public.offers
group by fuel_type
order by count(*) desc;
```

``` sql
-- Ten kod zwraca typy nadwozi i liczbę ofert dla każdego typu w tabeli "public.offers", posortowane malejąco.
select body_type, count(*) as offers
from public.offers
group by body_type
order by count(*) desc;
```

``` sql
-- Ten kod zwraca typy skrzyń biegów i liczbę ofert dla każdego typu w tabeli "public.offers", posortowane malejąco.
select transmission, count(*) as offers
from public.offers
where transmission is not null
group by transmission
order by count(*) desc;
```

``` sql
-- Ten kod zwraca informacje o tym, czy pojazdy były zaangażowane w wypadki lub były uszkodzone, i liczbę ofert dla każdej kombinacji tych dwóch cech w tabeli "public.offers", posortowane według cechy "damaged".
select no_accident, damaged, count(*) as offers
from public.offers
group by no_accident, damaged
order by damaged;
```




