# Data analysis: a cross-sectional overview of the car sales market in Poland based on offers from the Otomoto portal

![Two hands shake, car behind](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/main_graphic.jpg?raw%253Dtrue | width=100)



## Table of contents

1. **Introduction**
2. **Dealer Type**
3. **Car Condition**
    - Accident-free cars
    - Damaged cars
4. **Body Type**
    - Body type per year
5. **Fuel / Engine Type**
    - Fuel type per year
6. **Automatic / Manual Transmission**
    - Transmission type per year
7. **Fuel Consumption in the City**
8. **Electric Energy Consumption in the City**
9. **Car Colors**
    - Car segment vs. percentage of colorful vehicles
10. **Country of Origin of Used Cars**
11. **Most Popular Car Brands**
    - Most popular car models
    - Most popular cars by voivodeship
12. **Offers Count by Year of Production**
13. **Mileage Analysis**
    - Median mileage by production year 
14. **Price Analysis**
    - Average used car price per year
    - Price ranges for the 20 most popular vehicle brands
15. **Case: Clean Transport Zone in Krakow**
    - Price analysis of cars eligible to enter the Clean Transportation Zone
16. **Summary**


## Introduction

This is a project to analyze the data of the automotive market in Poland based on data from offers from Otomoto - the most popular portal with car offers in Poland. In the earlier part - [Data preparation & Data Cleaning](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/data_cleaning.md) the sales offer data from Otomoto was cleaned and prepared for analysis.

Let's start this part by presenting basic data about the *Offers* table: 
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

**Conclusions:** 

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

### Accident-free cars

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

### Damaged cars

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

Let's find out what makes up these results - for example, is Combi's high score due to previous years?

### Body type per year

Limiting the *production_year* in the following query to 1990 is because there are relatively few pre-1990 cars among the offers, which would skew the results.

```sql
select
  body_type,
  production_year,
  count(*) as count
from public.offers
where production_year >= 1990
group by body_type, production_year
order by body_type, production_year desc;
```
**Car body type by year** 
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/body_type_by_year.png?raw=true)


**Conclusions:** 
* SUVs accounted for a considerable portion of the market until around 2010, but it was only after this period that their popularity began to increase. Among the cars from 2023 listed on Otomoto, as many as half are SUVs.
* Compacts have been similarly popular for 30 years, averaging about a dozen percent of all body types.
* The sedan segment has fallen victim to family cars - first Combi, which had their glory years between 2000 and 2015, and then SUVs. Today, sedans are an important market segment, but their popularity is declining. Likewise with Combi, which also seem to have fallen victim to SUVs.
* The minivan segment is also likely to be a victim of SUVs.
* The city car and small car segments are, regardless of the year of car production, a similar market share of a few percent. 
* Interestingly, in the case of car offers from the 1990s, convertibles have a share of more than 10% in some years. This probably consists of 2 factors - the first is the actual greater popularity of convertibles in the past. The second reason is that customers for an "everyday car" or "family car" will tend to look in newer models than those from 25-30 years ago. Hence, there are likely to be more unusual cars in this segment, such as convertibles.

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

It is clear that hybrid or electric cars are a rather new invention, and their low percentage may be due to the fact that they were not so common 5-10 years ago and the latest vintages of cars are not enough to accumulate. 

To check this, let's track the offers for a given year of production in terms of the fuel the vehicle uses.

### Fuel type per year

Similarly as in above case, limiting the *production_year* in the below query to 1990 is because there are relatively few pre-1990 cars among the offers, which would skew the results.

```sql
select
  fuel_type,
  production_year,
  count(*) as count
from public.offers
where production_year >= 1990
group by fuel_type, production_year
order by fuel_type, production_year desc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/fuel_by_year.png?raw=true)

**Conclusions:** 
* Gasoline dominates for most vintages, with a break between the 2010-2018 vintages, when diesel engines were the most popular.
* Gasoline + LPG became less popular in subsequent vintages. For the most recent vintages, gasoline+LPG is 1-2% of all cars.
* Hybrid and electric cars have started to become strongly popular since around 2018. For the 2023 vintage, they account for more than 17% of all offers.

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

### Transmission type per year

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
* A surprisingly large number of cars produced up to about 1995 are cars with automatic transmissions, certainly more than the average in Poland for all registered cars of a given vintage. This may be due to the fact that these cars are more than 30 years old and tend to be more expensive and rarer models imported from abroad, such as the US, where the share of cars with automatic transmissions has been much higher since the 1960s. 
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

![enegy_consumption_distribution](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/elektryk_kwh_per_100km.png?raw=true)

* The most common values are 16-18 kWh/100 km.
* Values greater than 21 kWh/100 km are rare - we can assume that a standard electric car listed on Otomoto consumes between 14 and 21 kWh.

## Car colors

Let's see how the proportion of car colors changed in subsequent years (starting in 1990) - which colors were losing popularity and which were gaining. 
 
```sql
select 	
	case
		when color in ('beige', 'brown') then 'beige/brown'
		when color in ('black') then 'black'
		when color in ('gray') then 'gray'
		when color in ('silver') then 'silver'
		when color in ('blue', 'navy blue', 'sky blue') then 'blue'
		when color in ('burgundy', 'red') then 'red'
		when color in ('golden', 'yellow') then 'golden/yellow'
		when color = 'green' then 'green'
		when color = 'orange' then 'orange'
		when color = 'purple' then 'other'
		when color = 'white' then 'white'
		else 'other'
		end as color_group,
	production_year,
	count(*) as count
from public.offers
where production_year >= 1990
group by color_group, production_year
order by count desc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/colors_per_year.png?raw=true)

The colors on the chart correspond to the colors of the vehicles they depict, for clarity of perception. 

**Conclusions:** 
* Gray is currently the most popular. Interestingly, its growth is on the decline among silver-colored cars, which dominated the 2000s. 
* White is also much more popular for cars made in 2023 than for those made 10 or 20 years ago. The perception of color has changed - from "cheapest" and "base" to desirable.
* Black over the years is equally popular, in the case of blue and red cars, it can be observed that cars produced 15-20 years ago were more often in these colors, but these are not significant declines.
* Interestingly, until the early 2000s, green was quite a popular color. The decline in the number of cars in this color was rapid after that time, and for the past 15 years its share has been negligible.

The main conclusion is that over the years, fewer cars are colored than they used to be.

Let's also see if the color of a car depends on the segment - that is, if "premium" brands are less colorful than "regular" brands.

### Car segment vs. percentage of colorful vehicles

To determine this, the first thing to do would be to answer the question - how do you divide vehicle brands into "premium" and "normal" ones? I decided to divide the brands into 3 categories:
- mainstream, whose median price for the brand is less than 60 000 PLN.
- premium, for which the median is between 60 000 PLN and 200 000 PLN 
- luxury brands, with a median of more than 200 000 PLN

``` sql
with car_brand_median_price as (
    select
        vehicle_brand,
        avg(price),
        percentile_cont(0.5) within group (order by price) as median_price,
		count(*) as vehicle_count
    from public.offers
    group by vehicle_brand
    order by median_price desc
)

select 
	case 
		when median_price > 200001 then 'luxury_brand'
        when median_price between 60000 and 200000 then 'premium_brand'
        when median_price < 60000 then 'mainstream_brand'
        end as segment,
	vehicle_brand,
	vehicle_count
from car_brand_median_price
where vehicle_count > 25
order by median_price desc
```
 ![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/segments.png?raw=true)

The division seems to make sense. Then we can move on to the second part, where for the segment we will determine the percentage of vehicles in monochrome shades and those in color.

```sql
with car_brand_median_price as (
    select
        vehicle_brand,
        avg(price),
        percentile_cont(0.5) within group (order by price) as median_price
    from public.offers
    group by vehicle_brand
    order by median_price desc
),
car_brand_segmentation as (
    select 
        vehicle_brand,
        median_price,
        case 
            when median_price > 200001 then 'luxury_brand'
            when median_price between 60000 and 200000 then 'premium_brand'
            when median_price < 60000 then 'mainstream_brand'
        end as segment
    from car_brand_median_price
    order by median_price desc
)

select
    cbs.segment,
    case
        when color in ('Yellow', 'Green', 'Red', 'Blue', 'Orange', 'Purple', 'Sky Blue', 'Navy Blue', 'Burgundy') then 'Vibrant Colors'
        when color in ('Gray', 'Silver', 'Black', 'White') then 'Monochromatic Colors'
    end as color_group,
    round(count(*) * 100.0 / sum(count(*)) over (partition by cbs.segment),1) as percentage
from
    public.offers as of
inner join car_brand_segmentation as cbs
    on of.vehicle_brand = cbs.vehicle_brand
where
    color is not null
    and (color in ('Yellow', 'Green', 'Red', 'Blue', 'Orange', 'Purple', 'Sky Blue', 'Navy Blue', 'Burgundy')
        or color in ('Gray', 'Silver', 'Black', 'White'))
group by
    cbs.segment, color_group
order by
    cbs.segment, count(*) desc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/are_less_colorful.png?raw=true)

As we can see, among mainstream vehicle brands, the percentage of colored vehicles is similar to that of luxury cars - 22% and 24%, accordingly. The situation is different in the case of "premium" cars, which, however, still serve as an everyday car. We are talking about brands such as Audi, BMW, Lexus or Volvo, for example. In their case, less than 15% of vehicles are colored. 

**A simplified (and humorous) conclusion:** 
* Regular cars are colorful.
* Cars for "serious businessmen" are not colorful.
* Luxury cars like Lamborghini or Aston Martin are again colorful. 


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

Analyzing the results, we can notice some interesting **insights**:

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

**Other observations:**
* *BMW*, *Volkswagen* and *Audi* are the most common brands in the listings. Interestingly, they are united by their country of origin - Germany. This coincides with observations from the earlier chart - Germany is unquestionably the most popular direction from which vehicles are imported in Poland.
* It can also be noted that there is no strong dominance of any of the brands - the most popular still has less than 10% share in the offers.

### Most popular car models

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

**Conclusions:**
* *Opel Astra* is the most common model on offer, despite the fact that Opel is only the 5th most popular brand. This means that among BMW or Volkswagen, the popularity is spread over multiple models, while Opel is dominated by one.

* The popularity of models such as *Audi A4*, *BMW 3 Series*, *BMW 5 Series* and *Audi A6* suggests that there is a demand for used cars of premium models in Poland.

### Most popular cars by voievodeship

We already know that BMW, VW and Audi are the brands with the most offers, and the most popular model is the Opel Astra. But how does the popularity look at the voivodeship level? Let's check.

```sql
with brand_counts as (
    select 
        voievodeship, 
        vehicle_brand, 
        count(*) as brand_count
    from 
        public.offers
    group by 
        voievodeship, 
        vehicle_brand
),
ranked_brands as (
    select 
        voievodeship, 
        vehicle_brand, 
        brand_count,
        row_number() over(partition by voievodeship order by brand_count desc) as rn
    from 
        brand_counts
)

select 
    voievodeship, 
    max(case when rn = 1 then vehicle_brand end) as top1_vehicle_brand,
    max(case when rn = 2 then vehicle_brand end) as top2_vehicle_brand,
    max(case when rn = 3 then vehicle_brand end) as top3_vehicle_brand
from 
    ranked_brands
where voievodeship is not null
group by voievodeship;
```

| voievodeship          | top1_vehicle_brand | top2_vehicle_brand | top3_vehicle_brand   |
|-----------------------|-------------------|-------------------|----------------------|
| **Dolnośląskie**          | Volkswagen        | BMW               | Audi                 |
| **Kujawsko-pomorskie**    | Volkswagen        | Opel              | Audi                 |
| **Łódzkie**               | Volkswagen        | BMW               | Audi                 |
| **Lubelskie**             | Audi              | BMW               | Ford                 |
| **Lubuskie**              | Volkswagen        | Audi              | Ford                 |
| **Małopolskie**           | Audi              | BMW               | Ford                 |
| **Mazowieckie**           | BMW               | Audi              | Volkswagen          |
| **Opolskie**              | Volkswagen        | Ford              | Audi                 |
| **Podkarpackie**          | Audi              | BMW               | Ford                 |
| **Podlaskie**             | BMW               | Audi              | Mercedes-Benz        |
| **Pomorskie**             | Volkswagen        | Audi              | BMW                  |
| **Śląskie**               | BMW               | Ford              | Volkswagen          |
| **Świętokrzyskie**        | BMW               | Audi              | Opel                 |
| **Warmińsko-mazurskie**   | Volkswagen        | Audi              | Ford                 |
| **Wielkopolskie**         | Volkswagen        | BMW               | Ford                 |
| **Zachodniopomorskie**    | Volkswagen        | Mercedes-Benz     | Ford                 |

At first glance, we see that in each of the 16 provinces, the most popular is either Volkswagen, Audi or BMW. 

However, the results are hard to analyze in this way - we can see the values for each province, but making conclusions about the brands is difficult. For this reason, the data will be presented in a different form, inspired by the sports medal classification. 

Each brand gets:
* "gold medal" for each province in which it is first, 
* "silver medal" for each province in which it is second,
* "bronze medal" for each province in which it is third.
```sql
with brand_ranks as (
    select 
        vehicle_brand, 
        case 
            when rn = 1 then '1st_place'
            when rn = 2 then '2nd_place'
            when rn = 3 then '3rd_place'
        end as rank,
        count(*) as count
    from (
        select 
            voievodeship, 
            vehicle_brand, 
            row_number() over(partition by voievodeship order by count(*) desc) as rn
        from 
            public.offers
        group by 
            voievodeship, 
            vehicle_brand
    ) as subquery
    where rn <= 3
    group by 
        vehicle_brand, 
        rank
)

select 
    vehicle_brand, 
    coalesce(sum(case when rank = '1st_place' then count end), 0) as first_place_count,
    coalesce(sum(case when rank = '2nd_place' then count end), 0) as second_place_count,
    coalesce(sum(case when rank = '3rd_place' then count end), 0) as third_place_count
from 
    brand_ranks
group by 
    vehicle_brand
order by first_place_count desc, second_place_count desc, third_place_count desc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/olimpiada.png?raw=true)

**Conclusions:**
* Although at the national level the number of BMW, Volkswagen and Audi offers is very similar, Volkswagen is the most popular vehicle in as many as 9 provinces ( meaning in 9 provinces the most sales offers are Volkswagens). 
* Audi is most popular in only 3 provinces, but is in the top three in as many as 13 of them.
* Ford is nowhere the most popular, but is in the top 3 in as many as 9 provinces.
* Mercedes and Opel close the pile - in both cases they are in 2nd place in one province, and in another they are once in 3rd place. 

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

## Mileage analysis

First let's analyze the relationship between mileage and the number of cars. For readability of the data, mileage has been grouped every 10,000 kilometers. New cars were also filtered out - their mileage, by definition, cannot be higher than a few-odd kilometers made during testing.

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

### Median mileage by production year 

Let's check how the median mileage relates to the year of production of the car. Let's see if this is a simple relationship (the older the year of production, the higher the mileage) or if the relationship is formed differently.

```sql
select 	production_year, 
		percentile_cont(0.5) within group (order by mileage_km) as median_mileage
from public.offers
group by production_year
having count(*) > 10
order by production_year desc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/mileage_vs_production_year.png?raw=true)

**Conclusions:**
* As the data is from May 2023, the 2022 and 2023 car offers are virtually new cars. Their median mileage is at a very low level (about 10 km).
* Later, with each successive vintage, there is a rapid increase in the median mileage. For a 10-year-old car, it is just under 200 000 km. 
* Interestingly, for cars of 2005-1998 vintage, the mileage increase slows down with each year. The maximum median mileage is for a 1998 vintage - 240 000 km.
* Later something very interesting happens - with each successive vintage the median mileage.... decreases. The hypothesis is that among cars older than 25 years, there are fewer "work oxen" for the daily commute every year, and more and more unusual vehicles - classics, convertibles, young timers. For cars of 1980 and older, the median mileage falls below 100 000 kilometers; for those older than 1960, it falls below 50 000 kilometers.

## Price analysis

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

### Average used car price per year

Now let's see how the year of production relates to the average price you have to pay for a car.

``` sql
select production_year, round(avg(price),-2)
from public.offers
where state = 'Used'
group by production_year
having count(*) > 5
order by production_year asc;
```
grup
**Average price for a car's year of manufacture**![average_car_price_by_year_plot](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/rok_producji_a_srednia_cena.png?raw=true)


Conclusions: 
* Data for vehicles manufactured before 1970 are too inconsistent and it is hard to make conclusions.
* The graph is arranged in a parabola - vehicles i  al -  produd from1970 to 2001 are getting cheaper, and those produced later are getting more expensive. On average, vehicles manufactured in 2001 are the cheapest - the price is PLN 15,500.
* The pace of price increases is initially small, which means that in exchange for a small increase in the average price to be paid you can purchase a car one year younger. Starting from the year of production 2011, prices begin to rise faster and faster, so that for the youngest vehicles the difference at the level of 2-3 years is several tens of thousands of PLN.

### Price ranges for the 20 most popular vehicle brands

 mdla 20 najpopularniejszych marek samochodów naLet's compare average prices for the 20 most popular car brands on Otomoto.

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
W tym celu utworzone zostanie 20 whisker box plots, dla każdej marki z osobna. Dla łatwiejszej analizy wykresy zostały uszeregowane w kolejności od największej mediany do najmniejszej i po
For this purpose, 20 whisker box plots will be created, for each brand separately. For easier analysis, the plots have been ranked in order from largest median to smallest, and groupowane po 3 lub 4 z wyjątkiem marki Mercedes.

Z racji mnogości danych, wizualnie wykresy wyglądają 

ed by 3 or 4 with the exception of the Mercedes brand.

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

## Case: Clean Transport Zone in Krakow

Due to EU regulations, Krakow (and other cities in Poland) has been required to implement Clean Transportation Zone regulations. 

The clean transport zone (according to current plans) means that only electric cars, hybrid cars, gasoline cars with engines meeting the Euro 3 standard (i.e. made after 2000) and diesel cars meeting the Euro 5 standard (i.e. made after 2010) will enter the city. 

So let's check how big a "threat" this zone is - how many vehicles will be affected. To do this, we'll count the percentage of offers issued in the Malopolska voivodeship in which vehicles meet the Clean Transportation Zone standards.

``` sql
with clean_transport_zone as (
    select
        id,
        fuel_type,
        production_year,
        voievodeship,
        price,
		damaged,
		currency,
        case
            when fuel_type = 'Diesel' and production_year < 2010 then false
            when fuel_type in ('Gasoline', 'Gasoline + CNG', 'Gasoline + LPG') and production_year < 2000 then false
            else true
        end meets_ctz_requirements
    from public.offers
)

select
    count(*) as total_count,
    count(*) filter (where meets_ctz_requirements) as meets_ctz_count,
    round((count(*) filter (where meets_ctz_requirements)::numeric / count(*)) * 100,1) as percentage
from clean_transport_zone 
where damaged is false and voievodeship = 'Małopolskie' and currency = 'PLN' and production_year > 1985;
```
| total_count | meets_ctz_count | percentage |
|-------------|-----------------|------------|
| 16751       | 14598           | 87.1       |

More than 87% of vehicles for sale in the Lesser Poland province meet the CTZ's objectives. The bottom line is this - if our current vehicle does not meet these assumptions, replacing it with a vehicle that meets the standards should not be a problem.

Now let's check how this looks broken down by vehicle price - how much should be paid for such a vehicle. 

### Price analysis of cars eligible to enter the Clean Transportation Zone
```sql

with clean_transport_zone as (
    select
        id,
        fuel_type,
        production_year,
        voievodeship,
        price,
		damaged,
		currency,
        case
            when fuel_type = 'Diesel' and production_year < 2010 then false
            when fuel_type in ('Gasoline', 'Gasoline + CNG', 'Gasoline + LPG') and production_year < 2000 then false
            else true
        end meets_ctz_requirements
    from public.offers
)

select
    case
        when price between 0 and 5000 then '0-5k'
        when price between 5001 and 10000 then '5-10k'
        when price between 10001 and 15000 then '10-15k'
        when price between 15001 and 20000 then '15-20k'
        when price between 20001 and 25000 then '20-25k'
		when price between 25001 and 30000 then '25-30k'
		when price between 30001 and 35000 then '30-35k'
		when price between 35001 and 40000 then '35-40k'
		when price between 40001 and 45000 then '40-45k'
		when price between 45001 and 50000 then '45-50k'
        else 'more than 50k'
    end as price_group,
    count(*) as total_count,
    count(*) filter (where meets_ctz_requirements) as meets_ctz_count,
    round(count(*) filter (where meets_ctz_requirements)::numeric / count(*)) * 100,2) as percentage
from clean_transport_zone 
where damaged is false and voievodeship = 'Małopolskie' and currency = 'PLN' and production_year > 1985
group by price_group
order by price_group asc;
```
![enter image description here](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/plots/price%20vs%20sct.png?raw=true)

As we can see, 4/10 of vehicles up to PLN 5,000 will enter the projected clean transport zone, which means that even among the cheapest vehicles it is possible to find quite a few such vehicles.

On the graph there is a line drawn at 67% - symbolically indicating the range for which the vast majority (2/3) meet the requirements. In the price groups that meet this assumption, it is very easy to find a car that will enter the SCT. The first price group that meets this assumption is the 20-25 thousand zloty level.

The conclusions are as follows: the current assumptions of the Clean Transportation Zone do not seem revolutionary - if we assume that the car sales market in Poland is fairly representative of the entire picture of motorization in Poland, most vehicles meet the assumptions. The possible replacement of a vehicle with one that meets the assumptions should not be a major price barrier.

## Summary

The analysis of the data proved to be truly extensive and comprehensive. The analysis took the form of an analysis of the automotive market in Poland and could be, for example, a basis for building a report on the subject, e.g. for consultants for a quick understanding of the area.

**Let's summarize here the most important information in the form of bulletpoints.** 

* Half of the offers on Otomoto come from individuals, 35% from dealers, and 15% from authorized dealers.
* 9/10 of vehicles are used vehicles
* Just over half are accident-free vehicles.
* Of the accident vehicles, only a small proportion are still damaged cars.
* Offers with SUVs are most numerous, in second place we have Combi, then Compacts
* There are more gasoline cars than diesel ones, and there are 2 times more hybrids than electrics.
* The ratio of offers of cars with manual transmissions to those with automatic transmissions is 60:40, among cars of recent vintage, those with automatic transmissions dominate.
* Average cars burn between 5 and 9 liters per 100 km, while electric cars burn between 16 and 18 kWh per 100 km.
* Gray is the most popular car color, with the number of colored vehicles decreasing over time.
* Germany dominates among vehicle import destinations - France is second with 6 times fewer vehicles.
* From outside Europe, the only significant import destinations are the US, Canada and Japan.
* BMW, VW and Audi are the most popular brands in Poland.
* The most popular model is the Opel Astra.
* Mileage analysis: once the mileage exceeds 200,000 km, the number of offers decreases sharply. 
* Most are vehicles up to PLN 20,000.
* Vehicles from 2001 are the cheapest - older cars become more expensive due to their rarity.

Author: Wiktor Mastalerz
