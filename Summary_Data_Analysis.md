# Summary Data Analysis

## Table of contents

1. Introduction
2. Dealer type
3. Car condition
4. Accident-free cars
5. Damaged cars
6. Body type
7. Fuel / Engine Type
8. Automatic / Manual transmission
9. Fuel consumption in the city
10. Electric energy consumption in the city
11. Country of origin of used cars
12. Most popular car brands
13. Most popular car models
14. Offers count by year of production
15. Mileage distribution
16. Price distribution
17. Average used car price per year
18. Price ranges for the 20 most popular vehicle brands
19. Summary

## Introduction

In [Data preparation & Data Cleaning](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/data_cleaning.md) the sales offer data from Otomoto was cleaned and prepared for analysis. 


Let's start by presenting the Offers table: 
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

The offers table has 44 columns and 208,186 items. To get a better idea of the table, let's print 5 rows of all columns:

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

As can conclude from the above table, each row contains information about distinct car listing. Key details include the price, vehicle brand, model, generation, production year, mileage, fuel type, power, transmission, body type, and more.


## Dealer type

The first of the questions we will look for answers to is who is listing on Otomoto. It will allow us to better understand the nature of this portal - whether it is rather ordinary users who list their cars, or whether professional dealers prevail.

``` sql
select seller_type, count(*)
from public.offers
group by seller_type
order by count(*) desc;
```

![dealer_type_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/seller_type.png?raw=true)

* Most listings are from private individuals. There is certainly the phenomenon of dealers who occasionally acquire a car abroad to make money on the sale, or sellers who dishonestly pretend that they are not dealers. Nevertheless, it can be assumed that offers from private individuals account for about 50% of offers on the platform.

* Car dealers are the second largest source of listings (**72 460**). This shows that dealers are also using this platform to sell cars.

* Listings from authorized dealers are less numerous (**28,940**). This may indicate that Otomoto is not likely to be a platform for authorized dealers.

## Car condition

Let's take a look at the state of the vehicles displayed on the platform - whether they are new or used cars.

``` sql
select state, count(*)
from public.offers
group by state
order by count(*) desc;
```
![car_condition_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/car_condition.png?raw=true)

Most listings on Otomoto are for used cars. Only one in 10 listings is a new car. 

## Accident-free cars

Let's analyze how many listed cars are accident-free. We filter out new cars, as these generally have not been involved in accidents.

``` sql
select no_accident, count(*)
from public.offers
where state = 'Used'
group by no_accident
order by count(*) desc;
```

![no_accident_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/no_accident.png?raw=true)

After filtering out new vehicles, there is a slight lead in listings with accident-free cars. However, the difference is small enough that, with some approximation, about half of used cars are accident-free.

## Damaged cars

Since about half of the cars on Otomoto were involved in some sort of traffic collision, how many of them have not been repaired and are listed as inoperable cars? Let's check:

``` sql
select damaged, count(*)
from public.offers
where state = 'Used' and no_accident is false
group by damaged
order by count(*) desc;
```
![damaged_cars_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/damaged.png?raw=true)

Approximately one in eight cars involved in an accident is listed on Otomoto as a car still inoperable and in need of repair.

## Body type

Let's take a look at vehicle body types:

``` sql
select body_type, count(*)
from public.offers
group by body_type
order by count(*) desc;
```
![body_type_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/body_type.png?raw=true)

Analyzing the results, we can see that the most common body type in the listings is *SUV* with 56068 listings, suggesting that SUVs are very popular in the market. Together with the next category on the list - *Station wagon (Combi)* - they account for 45% of listings. These results may suggest that most buyers on Otomoto are looking for cars with more space.

## Fuel / Engine Type


``` sql
select fuel_type, count(*)
from public.offers
group by fuel_type
order by count(*) desc;
```
![fuel_type_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/fuel_type.png?raw=true)

The first conclusion we can draw is the advantage of gasoline engine listings over diesel engine listings. Considering that about 7,500 offers are also gasoline engines, but also allow LPG refueling the advantage is even clearer. 

Turning to low-emission solutions, we see hybrids outnumbering electric cars by more than 2 times. Noteworthy, hydrogen cars are virtually non-existent.

## Automatic / Manual transmission
``` sql
select transmission, count(*) as offers
from public.offers
where transmission is not null
group by transmission
order by count(*) desc;
```
![transmission_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/transmision.png?raw=true)

Surprisingly, there is little disparity between cars with manual and automatic transmissions. Intuitively, in Poland, cars with manual transmissions have "always" dominated over those with automatic transmissions. This may be due to the fact that most listings on Otomoto are rather newer cars, and among them automatic transmissions are already a more common sight. 

Let's check this by adding the year to `select` and `group by`. We also filter out years of production for which less than 10 vehicles are listed - there are too few of them to build conclusions based on this.

``` sql
select transmission, production_year, count(*) as offers
from public.offers
where transmission is not null 
  	and production_year in (
			select production_year
			from public.offers
			group by production_year
			having count(*) >= 10
						   	)
group by transmission, production_year;
```
**Breakdown of cars into those with manual and automatic transmissions (share of 100%)**
![transmision_in_time_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/transmission_in_time.png?raw=true)


The chart covers data from 1958 to 2023. The conclusions are as follows:
* a surprisingly large number of cars produced up to about 1995 are cars with automatic transmissions, certainly more than the average in Poland for all registered cars of a given vintage. This may be due to the fact that these cars are more than 30 years old and tend to be more expensive and rarer models imported from abroad, such as the US, where the share of cars with automatic transmissions has been much higher since the 1960s. 
* Considering only the last 30 years, for cars of 1998-2009 vintage, the share of cars with automatic transmission is about 25%. 
* Among cars of 2010 and younger vintages, there is a steady and clear trend in the popularization of automatic transmission. 7 out of 10 cars produced in 2023 have such a transmission. Given that there are more offers of cars from these vintages than older models, this is the reason why the prevalence of cars with manual transmissions is not so high. 

## Fuel consumption in the city

Let's take a look at what the distribution of average combustion in the city looks like.

``` sql
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
from bins 
where bin_floor is not null and bin_floor != 'null'
order by case 
			when bin_floor = '>25' then null 
			else cast(bin_floor as integer) 
			end;
```

**Average fuel consumption in the city [l/100 km]**
![fuel_consumption_distribution](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/avg_fuel_consumption.png?raw=true)

* Most cars fall in the fuel consumption range of 6 to 7 liters per 100 km, with 21500 offers.
* Two-thirds burn between 5 and 9 liters of fuel per 100 km. The number of offers of cars in the fuel consumption ranges of more than 9 liters per 100 km is starting to decline sharply.

## Electric energy consumption in the city

About 3,500 offerings are electric cars. Thus, let's check what the energy consumption is among them. It is important to limit ourselves to electric cars only, without hybrid cars - there are more of these among the bids, so it would strongly affect the results by incorrectly lowering them.
```sql
with bins as (
  select
  floor(average_consumption_kwh_per_100km/1.00)*1 as bin_floor,
  count(*) as count
from public.offers
where fuel_type = 'Electric'
group by 1
order by 1
)
select
  bin_floor,
  bin_floor || ' - ' || (bin_floor + 1) as bin_range,
  count
from bins
where bin_floor is not null
order by 1;
```
**Average energy consumption in the city [kWh/100 km]**

![energy_consumption_distribution](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/elektryk_kwh_per_100km.png?raw=true)

* The most common values are 16-18 kWh/100 km.
* Values greater than 21 kWh/100 km are rare - we can assume that a standard electric car listed on Otomoto consumes between 14 and 21 kWh.

## Country of origin of used cars

It is widely assumed that used cars in Poland are most often from Germany. See if the data supports this.

``` sql
select country_of_origin, count(*)
from public.offers
where state = 'Used' and country_of_origin is not null and country_of_origin <> 'Poland'
group by country_of_origin
order by count(*) desc;
```
**Country of origin for used cars**
The chart divides countries by color into Europe and the rest of the world.![coutries_of_origin_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/used_cars_origin.png?raw=true)

Let's see how the same data looks on a maps. 

**The number of offers in which a country was indicated as the place of origin.**![map_of_europe_with_number_of_cars_from_each_country](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/map_europe.png?raw=true)
![map_of_na_with_number_of_cars_from_each_country](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/map_america.png?raw=true)
![map_of_asia_with_number_of_cars_from_each_country](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/map_asia.png?raw=true)

Analyzing the results, we can notice some interesting insights:

* Germany is the dominant import destination. From the second country in terms of the number of cars (France) come 6 times fewer vehicles.
* The U.S., despite being on another continent, which requires transport by container ship, is in 3rd place.
* Almost 2 times as many vehicles come from Canada as from all of Poland's neighbors (except Germany) combined.
* The vast majority of cars come from Western Europe. Almost 80% of vehicles come from Germany, France, Belgium, Switzerland or the Netherlands. 
* The only non-European countries from which the cars listed on Otomoto come are the US, Canada and Japan. Japan is the only Asian country.

## Most popular car brands

Let's take a look at the most popular car brands.
``` sql
 select vehicle_brand, count(*) as brand_count
 from public.offers
 group by vehicle_brand
 order by brand_count desc;
```
![car_brands_popularity_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/car_brands.png?raw=true)


While it may be a controversial choice, I felt that this chart type was the best fit for this particular set of data. The total adds up to 100% which is represented by the form of a large rectangle. The small rectangles in the lower right corner illustrate the fragmentation of the market. 65% of the listings on Otomoto are cars from the top 10 companies - from BMW to Peugeot. The remaining 35% of vehicles are spread across exactly 100 brands. 

Other observations:
* *BMW*, *Volkswagen* and *Audi* are the most common brands in the listings. Interestingly, they are united by their country of origin - Germany. This coincides with observations from the earlier chart - Germany is unquestionably the most popular direction from which vehicles are imported in Poland.
* It can also be noted that there is no strong dominance of any of the brands - the most popular still has less than 10% share in the offers.

## Most popular car models

After looking at the most popular brands, it's also worth checking what brand-model combinations are most popular.

``` sql
select vehicle_brand, vehicle_model, count(*)
from public.offers
group by vehicle_brand, vehicle_model
order by count(*) desc
limit 10;
```
**10 most popular  brand-model combination**
![most_popular_car_models](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/top_10_most_popular_models.png?raw=true)
* *Opel Astra* is the most common model on offer, despite the fact that Opel is only the 5th most popular brand. This means that among BMW or Volkswagen, the popularity is spread over multiple models, while Opel is dominated by one.

* The popularity of models such as *Audi A4*, *BMW 3 Series*, *BMW 5 Series* and *Audi A6* suggests that there is a demand for used cars of premium models in Poland.

## Offers count by year of production

Let's take a look at what cars are most often listed on Otomoto. The newest ones, those that are a few years old, or maybe those that are slightly older? The following query will provide the answer:

``` sql
select production_year, count(*)
from public.offers
group by production_year
order by production_year asc;
```
![offers_by_production_year_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/count_by_production_year.png?raw=true)
* The number of listings has begun to increase significantly since the early 2000s. Older cars are at least 24 years old, and it is natural that fewer and fewer of them are roadworthy.
* Most listings are for cars manufactured in the post-2015 period, suggesting that these cars are now most often sold on the used market.
* The decline in the number of listings in 2020 and 2021 is interesting. The reason may be that used cars of a year or 2 are rarely sold, and the increase in 2022/2023 is due to new vehicles. A possible explanation is also problems with vehicle production during the pandemic - broken supply chains or problems with semiconductor availability may have contributed to fewer vehicle listings of these vintages.

## Mileage distribution

Let's analyze the relationship between mileage and the number of cars. For readability of the data, mileage has been grouped every 10,000 kilometers. New cars were also filtered out - their mileage, by definition, cannot be higher than a few-odd kilometers made during testing.

``` sql
with bins as (
  select
    floor(mileage_km/10000.00)*10000 as bin_floor,
    count(*) as count
  from public.offers
  where state != 'New'
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
**Mileage distribution [km]**
![mileage_distribution_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/mileage_distribution.png?raw=true) 

We see a steady increase in the number of offers from those vehicles with very low mileage (0-10,000 km) to 200,000 km. Interestingly, we can see that there are more offers with mileage of 90-100,000 kilometers than the trend line would suggest. 

The reason for this may be the popularity of vehicles with mileage under 100,000 kilometers - these are the vehicles that dealers are looking for, as 100,000 kilometers seems to be the round filter to select when someone wants to buy a vehicle with relatively low mileage. 

There is also a strong decline in the number of offers for cars with mileage of 200,000 kilometers or more. Virtually all vehicles are in the range up to 400,000 km - fewer than 1,000/208,000 listings have higher mileage. 

## Price distribution

Let's take a look at the most common prices for the vehicles listed on Otomoto. Similar to the example above, we have grouped the prices in increments of 5 000. Additionally, any vehicles priced over 750 000 have been placed in Group 1. This was done to avoid overcrowding the horizontal axis of the chart with single results in increments of 5 000, which would make it less readable. 

``` sql
with bins as (
  select
    case 
      when floor(price/5000.00)*5000 > 500000 then '>500000'
      else cast(floor(price/5000.00)*5000 as text)
    end as bin_floor,
    count(*) as count
from public.offers
where currency = 'PLN'
group by 1
order by 1
)

select 
  bin_floor,
  case 
    when bin_floor = '>500000' then bin_floor 
    else bin_floor || ' - ' || (cast(bin_floor as integer) + 5000) 
  end as bin_range,
count
from bins where bin_floor is not null 
	and bin_floor != 'null'
order by case 
			 when bin_floor = '>500000' then null 
			 else cast(bin_floor as integer) 
			 end;
```
**Price distribution [PLN]**
![price_distribution_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/price_distribution.png?raw=true)

* Cars in the price range from 10 to 20 thousand PLN are the most numerous. 
* Above 25 000 PLN the rate of decrease is significant. 
* The most interesting observation seems to be the spikes for every second value. The regularity on the chart is that the value for the range of, for example, 35-40k is higher than both 30-35k and 40-45k. Probably, this is related to "fitting" in the fork below the even amount - the difference between listing a car for, say, 39k and 41k is small, and this allows us to fit in the fork below the even amount, which increases the probability of a sale.

## Average used car price per year

Now let's see how the year of production relates to the average price you have to pay for a car.

``` sql
select production_year, round(avg(price),-2)
from public.offers
where state = 'Used'
group by production_year
having count(*) > 5
order by production_year asc;
```

**Average price for a car's year of manufacture**![average_car_price_by_year_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/rok_producji_a_srednia_cena.png?raw=true)


Conclusions: 
* Data for vehicles manufactured before 1970 are too inconsistent and it is hard to make conclusions.
* The graph is arranged in a parabola - vehicles produced from 1970 to 2001 are getting cheaper, and those produced later are getting more expensive. On average, vehicles manufactured in 2001 are the cheapest - the price is PLN 15,500.
* The pace of price increases is initially small, which means that in exchange for a small increase in the average price to be paid you can purchase a car one year younger. Starting from the year of production 2011, prices begin to rise faster and faster, so that for the youngest vehicles the difference at the level of 2-3 years is several tens of thousands of PLN.

## Price ranges for the 20 most popular vehicle brands

Let's compare average prices for the 20 most popular car brands on Otomoto.

``` sql
select vehicle_brand, price
from public.offers
where currency = 'PLN' 
	and vehicle_brand in (select vehicle_brand
						from public.offers 
						group by vehicle_brand
					   	order by count(*) desc
					   	limit 20);
```

For this purpose, 20 whisker box plots will be created, for each brand separately. For easier analysis, the plots have been ranked in order from largest median to smallest, and grouped by 3 or 4 with the exception of the Mercedes brand.

Because of the plethora of data, visually the charts look as if there are a lot of outliers, but this is mainly due to the amount of data for each brand.

**Mercedes prices**
![mercedes_whisker_boxplot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/mercedes_whisker.png?raw=true)

Of the 20 most popular car brands on Otomoto, Mercedes are among the most expensive. The median price is 103 000 PLN, and 50% of the values are between  38 000 PLN and  220 000 PLN. Mercedes is also the only brand for which many outliers exceed one million zlotys, there are more than 180 of them. 

As for the rest of the brands, the lower whisker includes very low values and is located at the level of 2 000 PLN, which means that it is possible to buy a Mercedes already for such money, although it will be a legitimately old, worn-out and potentially damaged vehicle.

**BMW, Audi and Volvo prices**
![whisker_plot_prices_bmw_audi_volvo](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/bmw_audi_volvo_whisker.png?raw=true)

For each of the above brands, 50% of the values fall within a similar range, from about 32 000-35 000 PLN to 145 000-185 000 PLN. The median for BMW is 80 000, for Audi 70 000, and for Volvo 66 000 PLN. The main differences between the brands are the ranges of the upper whisker - for BMW it is more than 405 000 PLN, for Audi 345 000 PLN, and for Volvo 305 000 PLN. Volvo also stands apart in terms of outliers - the most expensive vehicle is listed at 555 000 PLN, where for both BMW and Audi there are several hundred vehicles each priced above 600,000 PLN.

**Mazda, Kia and Toyota prices**
![mazda_kia_toyota_whiser_box_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/mazda_kia_toyota_whisker.png?raw=true)

The median price for Mazda and Kia is about 58 000 PLN and for Toyota the value is 55 000 PLN. The values for the top whiskers are very similar for each of the 3 brands, ranging from  190 000 PLN to 200 000 PLN. Toyota stands out with a few vehicles with an offer price above 500 000 PLN.

**Skoda, Hyundai and Volkswagen prices**
![skoda_hyundai_vw_whisker_boxplot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/skoda_hyuindai_volkswagen_whisker.png?raw=true)

Mediana dla Skody, Hyundaia i VW mieści się pomiędzy 50 a 55 tysięcy złotych. Volkswagen wyróżnia się na tle pozostałych największym zakresem wąsów wykresu - mieszczą one wartości pomiędzy 800 a 211 000 zł. Jako jedyny posiada również wartości odstające powyżej 350 000 zł.

**Nissan, Ford and Honda prices**
![nissan_ford_honda_boxplot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/nissan_ford_honda_whisker.png?raw=true)

The median for Skoda, Hyundai and VW is between 50 000 PLN and 55 000 PLN. Volkswagen stands out from the rest with the largest range of whiskers on the chart - they range in values between 800 and 211 000 PLN. It is also the only one with outliers above 350 000 PLN.

**Renault, Peugeot, Suzuka and Seat prices**
![renault_peugeot_suzuki_seat_boxplot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/renault_peugeot_suzuki_seat_whisker.png?raw=true)

The median for all 4 vehicle brands is between 36 000 PLN and 33 000 PLN. Suzuki stands out from the other 4 - whiskers cover the largest range of values, from PLN 1 600 to 150 000 PLN, but there are virtually no outliers - only 20. It also has the lowest maximum outlier of all 20 brands - at 218 900 PLN.

**Opel, Fiat and Citroen prices**
![opel_fiat_citroen_boxplot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/whisker_plots/opel_fiat_citroen_whisker.png?raw=true)

Median prices for these brands range from 30 000 to 29 000 PLN. Citroen is the only one of the 20 most popular to have values for 75% of the offers below PLN 50 000 PLN.

## Summary

to be added
