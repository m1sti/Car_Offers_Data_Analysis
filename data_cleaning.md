# Data preparation & Data Cleaning

## Table of contents

 1. [**Introduction and preparation of the environment**](#introduction-and-preparation-of-the-environment)
 2. [**Basic table information and exclusion of most columns**](#basic-table-information-and-exclusion-of-most-columns)
 3. [**Data preparation & Data Cleaning**](#data-preparation--data-cleaning)
	- [Problem List with Explanation and Reference to Solution](#problem-list-with-explanation-and-reference-to-solution)
 4. [**Summary**](#summary)

## Introduction and preparation of the environment

The purpose of the project is to analyze vehicle sales listings from the Otomoto portal. This data is capable of answering many interesting questions, which is covered in the part of the project related to summary data analysis and in-depht analysis. 

Before starting to analyze the data, it is crucial to properly prepare the working environment. In the case of this project, the process involved several key steps:

 1. Downloading data from Kaggle in the form of a CSV file. A link to the dataset can be found [here](https://www.kaggle.com/datasets/szymoncyperski/car-sales-offers-from-otomotopl-2023/data).

2. Setting up a local PostgreSQL Database on my macOS, tutorial under this [link](https://www.youtube.com/watch?v=wTqosS71Dc4).
    
3. Loading a CSV file into a local PostgreSQL database using pgAdmin4. Instructions on how to do this can be found under this [link](https://www.youtube.com/watch?v=UdMj8iKSCoc).

4. The result is a new table in the database named *Offers_all*.

## Basic table information and exclusion of most columns

In this section, we introduce the database table named *Offers_all* and proceed to determine the count of rows in that table. 

``` sql  
select count(*) as row_count
from public.'Offers_all';
``` 

The table *Offers_all* contains **208 205** rows of sales offers.

Poniżej liczba kolumn:
``` sql  
select count(*)
from information_schema.columns
where table_name = 'Offers_all';
``` 

The table *Offers_all* has a total of **243** columns. This appears to be quite extensive, exceeding the requirements for the current analysis and making it challenging to cover comprehensively in a single analysis.

Next, let's analyze the columns. The following two queries will display the first 5 rows of the *Offers_all* table and list all columns along with their data types.

``` sql  
select *
from public.'Offers_all'
limit 5;
``` 

``` sql  
select 	column_name, data_type
from information_schema.columns
where table_name = 'Offers_all';
``` 

Due to the volume of data, I won't present the results here. In summary, most rows contain information about whether a specific feature is present in a car listed in the offer, for example column *side_airbags_front* data looks like this:

|side_airbags_front|
|--|
| false |
| false |
| true |

After reviewing the contents of the table, I've decided that the detailed equipment of the vehicle will not be the subject of analysis. For this reason, I've selected the following columns for further analysis by **creating a new table called *Offers***:

``` sql  
create table public.Offers as
select
	id
	,cast(offer_creation_date AS timestamp) as offer_creation_date 					
	,offer_title
	,price 
	,currency 
	,seller_type 
	,location 
	,vehicle_brand 
	,vehicle_model 
	,generation 
	,production_year 
	,mileage 
	,engine_displacement 
	,fuel_type 
	,power 
	,transmission 
	,body_type 
	,number_of_doors 
	,number_of_seats 
	,color 
	,state 
	,version 
	,country_of_origin 
	,date_of_first_registration_in_vehicle_history 
	,fuel_consumption_in_city 
	,average_consumption 
	,color_type 
	,drive_type 
	,registered_in_poland 
	,first_owner_from_new 
	,no_accident 
	,damaged 
	,manufacturers_warranty_period 
	,tuning 
	,or_to_mileage_km 
	,combustion_in_the_mixed_cycle 
	,serviced_at_aso 
	,rear_distance_control_when_parking 
	,distance_control_in_front_when_parking 
	,rear_parking_camera 
	,apple_carplay 
	,android_auto
from public."Offers_all";
``` 

### Number of columns in new table

``` sql  
select count(*)
from information_schema.columns
where table_name = 'offers';
``` 
Although there are still a considerable number of columns, as indicated by the query above, **the newly created table has 44 columns**. Virtually all of them, with a few exceptions, do not pertain to the interior equipment of the vehicle and are essential for the analysis.

### Why Create a New Table?

The decision was made to simplify the analysis by creating a new table, selecting only those columns from the previous table that are relevant to the analysis. If needed or if plans change, additional data can be incorporated into the analysis, possibly through `join` operations with the previous table.

## Data preparation & Data Cleaning

Let's begin by reviewing the newly created table.

``` sql  
select column_name, data_type
from information_schema.columns
where table_name = 'offers';
``` 

| Column Name                               | Data Type                          | Example                              |
| ----------------------------------------- | ---------------------------------- | ------------------------------------ |
| id                                        | bigint                             | 6106252111                           |
| offer_creation_date                       | timestamp without time zone        | 2023-04-20 14:52:00                  |
| price                                     | bigint                             | 23200                                |
| production_year                           | bigint                             | 2010                                 |
| number_of_doors                           | double precision                   | 5                                    |
| number_of_seats                           | double precision                   | 5                                    |
| rear_distance_control_when_parking        | boolean                            | TRUE                                 |
| distance_control_in_front_when_parking    | boolean                            | TRUE                                 |
| rear_parking_camera                       | boolean                            | TRUE                                 |
| apple_carplay                             | boolean                            | TRUE                                 |
| android_auto                              | boolean                            | TRUE                                 |
| power                                     | text                               | 109 KM                              |
| transmission                              | text                               | Manual                               |
| body_type                                 | text                               | Station wagon                        |
| color                                     | text                               | Burgundy                             |
| state                                     | text                               | Used                                 |
| version                                   | text                               | 2.0 Comfort                          |
| country_of_origin                         | text                               | Germany                              |
| date_of_first_registration_in_vehicle_history | text                           | 28/01/2006                           |
| fuel_consumption_in_city                  | text                               | 10 l/100km                           |
| average_consumption                       | text                               | 9,50 kWh/100km                       |
| color_type                                | text                               | Metallic                             |
| drive_type                                | text                               | 4x4 (manually attached)              |
| registered_in_poland                      | text                               | Tak                                  |
| first_owner_from_new                      | text                               | Tak                                  |
| no_accident                               | text                               | Tak                                  |
| damaged                                   | text                               | Tak                                  |
| manufacturers_warranty_period             | text                               | 17/05/2027                           |
| tuning                                    | text                               | Tak                                  |        
| offer_title                               | text                               | Volvo V70                            |
| currency                                  | text                               | PLN                                  |
| seller_type                               | text                               | Dealer                               |
| location                                  | text                               | Łużycka 14B - 72-600 Świnoujście (Polska) |
| vehicle_brand                             | text                               | Volvo                                |
| vehicle_model                             | text                               | V70                                  |
| generation                                | text                               | III (2007-)                          |
| mileage                                   | text                               | 304 000 km                           |
| engine_displacement                       | text                               | 1 560 cm3                            |
| fuel_type                                 | text                               | Diesel                               |


### Problem List with Explanation and Reference to Solution

####  1. Unnecessary, repetitive characters next to numerical values, causing them to be treated as text with no analytical value, i.e., calculations or aggregations cannot be performed on them:

A total of 5 columns required modification. Due to their similarity, they have been divided into 2 groups.

-   **Group 1:**
    
    -   **engine_displacement**: an example value from the column looks like: "*1 560 cm3*" and has a `text` type. This prevents quantitative analysis such as aggregation or summation. The solution is to move "*cm3*" to the column name and transform the remaining into a numerical value, e.g., `bigint`.
    -   **mileage**: an example value from the column looks like: "*304 000 km*". The issue and solution are analogous to the above.
    -   **power**: an example value from the column looks like: "*109 HP*". The issue and solution are analogous to the above.

-   **Group 2:**
    
    -   **fuel_consumption_in_city**: an example value from the column looks like: "*6,5 l / 100 km*". The issue and solution are quite analogous to the above, the difference is the comma in the value.
    -   **average_consumption**: average power consumption per 100 km. An example value from the column looks like: "*8.50 kWh/100km*". The issue and solution are analogous to the above.

**Solving the group 1 problem using the example of *engine_dispalcement*:**
``` sql
update public.offers
set engine_displacement = regexp_replace(engine_displacement, '[^0-9]', '', 'g');

alter table public.offers
rename column engine_displacement to engine_displacement_cm3;

alter column engine_displacement_cm3 type bigint using engine_displacement_cm3::bigint;
``` 
Removing all non-numeric characters from the *engine_displacement* column, renaming it to *engine_displacement_cm3* for context, transforming values like "*1 640 cm3*" to "*1640*", and changing the data type from `text` to `bigint`:

Query for the *mileage*  and  *power* columns is analogous.

**Solving the group 2 problem using the example of *fuel_consumption_in_city*:**
``` sql
update public.offers
set    fuel_consumption_in_city = cast (
       regexp_replace(regexp_replace(
                            regexp_replace(
                            fuel_consumption_in_city,
                            '\sl/100km', ''), '\s',
                            '', 'g'), ',', '.') as
       numeric);

alter table public.offers
rename column fuel_consumption_in_city to fuel_consumption_in_city_l_per_100km
;
```
Query updates the *fuel_consumption_in_city* column by removing any spaces, commas, and the "*l/100km*" suffix from the existing values. It then casts the modified values to the numeric data type. Additionally, it renames the column to *fuel_consumption_in_city_l_per_100km* using the alter table statement.

#### 2. The columns with date values but `text` data type:

- ***date_of_first_registration_in_vehicle_history***:  values in the column are of data type `text`, preventing operations suitable for date formats.
- ***manufacturers_warranty_period***: similar issue.

**Solution:**

``` sql
alter table public.offers
add column first_registration_date date;

set first_registration_date = to_date(date_of_first_registration_in_vehicle_history, 'DD/MM/YYYY');

alter table public.offers
drop column date_of_first_registration_in_vehicle_history;
``` 
Create a new column *first_registration_date* with a data type of `date`. Set the values for this column from the *date_of_first_registration_in_vehicle_history* column using the `to_date` function. Finally, drop the *date_of_first_registration_in_vehicle_history* column.

For the second column - *manufacturers_warranty_period* - the process is analogous.

#### 3. Columns with data representing a binary choice are using "*Tak/Nie*" instead of True/False:

-   ***no_accident*** - there is text "Tak" or "Nie" instead of boolean True/False.
-   ***damaged*** - as above.
-   ***tuning*** - as above.
-   ***first_owner_from_new*** - as above.
-   ***registered_in_poland*** - as above.

**Solution:**
``` sql
update public.offers
set no_accident = case when no_accident = 'Tak' then 'true' else 'false' end;

alter table public.offers
add column no_accident_bool boolean;

update public.offers
set no_accident_bool = (no_accident = 'true')::boolean,

alter table public.offers
drop column no_accident,
rename column no_accident_bool to no_accident;
``` 
Updates the ***no_accident*** column by replacing the values 'Tak' with 'true' and any other values with 'false' using a `case` statement. Subsequently, it adds a new column named ***no_accident_bool*** to the table with the boolean data type. 

Following that, it updates the values in the new boolean column based on whether the corresponding *no_accident* column is equal to "*true*". Finally, it removes the original *no_accident* column and renames the *no_accident_bool* column to *no_accident*, effectively converting the original textual representation of accident status into a boolean format.

#### 4. The *generation* column contains information that, when split into 3 separate columns, will carry more meaningful values:


The *generation* column contains information about the vehicle's generation and the range of years. An example value looks like: "*III {2007-2015}*". However, the entire column is of type `text`, preventing proper analysis.

The solution is to separate the generation name and create a separate column for textual values. For the example above, it would be just "*III*." Additionally, two new columns would represent the starting and ending years of the generation, both as numerical values.

**Solution - Textual part of the generation:**
``` sql
alter table public.offers
add column generation_text text,

update public.offers
set generation_text = substring(generation from '^(.*) \\(');
```
First it adds a new column called *generation_text* of type `text`. Subsequently, it updates the values in the  *generation_text* column by extracting a substring from the existing  *generation* column, capturing everything from the beginning of the string until the first occurrence of a space followed by an opening parenthesis.

**Solution - Numerical values for the years of the generation:**
``` sql
alter table public.offers
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
```
This query adds a new column named *generation_years*.  Subsequently, it populates this column by extracting a substring from the existing *generation* column, specifically the portion after the space and opening brace. It then removes any occurrences of the brace characters in the *generation_years* column. 

Two additional columns, *generation_start* and *generation_end*, are added to the table. The values in these columns are derived by splitting and processing the *generation_years* values, representing the start and end of a range separated by a hyphen. The data types are then converted to `bigint`, and finally, the temporary column *generation_years* is dropped from the table.

**Results:**
``` sql
select generation, generation_text, generation_start, generation_end
from public.Offers
where generation is not null
limit 5;
```
| Generation        | Generation Text | Generation Start | Generation End |
|-------------------|------------------|------------------|-----------------|
| T9 {2014-2021}    | T9               | 2014             | 2021            |
| G01 {2017-}       | G01              | 2017             |                 |
| E24 {1976-1989}   | E24              | 1976             | 1989            |
| C8 {2018-}        | C8               | 2018             |                 |
| II {2002-2008}    | II               | 2002             | 2008            |

#### 5. The *location* column contains unstructured location information that hinders analytical use:

The *location* column contains unstructured location data. Sample values look like:

-   "Połczyńska 125 - 01-303 Warszawa, Bemowo (Polska)",
-   "Łużycka, Świnoujście, Zachodniopomorskie".

Issues:

-   Voievodeship is not always present.
-   Successive units are not always separated by commas.
-   Successive units do not always form a consistent pattern (e.g., city-district-province), as shown in the example where a district follows Warsaw (city with powiat rights).

Each time, the location includes the county (powiat). Therefore, it was decided to extract two types of values from the *location* column - the county name and the province name.

The solution involved scraping a list of Polish counties from Wikipedia, including the provinces to which these counties belong. List can be found under this link: [list of powiats in Poland](https://pl.wikipedia.org/wiki/Lista_powiatów_w_Polsce).

<zdjęcie tabeli z Wiki>

The list was then processed in a spreadsheet to match the format of the county names in the *location* column. The finalized list was exported to a CSV file. Then, the CSV file was loaded into a local PostgreSQL database using pgAdmin4.

**Adding a new table  *location*:**
``` sql
create table public.location(
 poviat text
,poviat_main_city text
,voivodeship text
,area_km2 text
,count_of_people numeric
,population_density numeric
);

copy public.location 
from '/Users/m1sti/Downloads/location.csv' delimiter ',' csv header;
```
 Query above creates a table named *location* with columns: 
 - poviat,
 - poviat_main_city,
 - voivodeship,
 - area_km2,
 - count_of_people,
 - population_density,

with their respective data types. Following the table creation, the `copy` command is used to populate the *location* table with data from a CSV file.

**Extracting powiat and voievodeship from  *location*:**
``` sql
alter table public.offers
add column powiat varchar(255);

update public.offers
set powiat = (
  select poviat
  from public.location
  where public.offers.location ilike '%' || poviat || '%'
  limit 1
);

update public.offers
set voievodeship = public.location.voivodeship
from public.location
where public.offers.powiat = public.location.poviat
  and public.offers.voievodeship is null
  and public.offers.powiat is not null;

alter table public.offers
drop column location_voivodeship;
```
Above query adds a new column *powiat* with a data type of `varchar(255)`. Subsequently, it updates the values in the  *powiat* column by matching records in the *location* table based on a partial match with the *location* column in the *offers* table. 

Additionally, it updates the *voievodeship* column by matching records with the *poviat* column in the *location* table. Finally, it drops the *location_voivodeship* column from the *offers* table.

**Results:**
``` sql
select location, voievodeship, powiat
from public.Offers
limit 5;
```
| Location                                                      | Voievodeship  | Powiat      |
|---------------------------------------------------------------|---------------|-------------|
| Częstochowa, Lisiniec                                          | Śląskie       | Częstochowa |
| Sieradz, sieradzki, Łódzkie                                    | Łódzkie       | sieradzki    |
| Wrocław, Dolnośląskie, Psie Pole                               | Dolnośląskie  | Wrocław     |
| Zakopiańska 167 - 30-435 Kraków, Podgórze (Polska)              | Małopolskie   | Kraków      |
| ul. ŚLĄSKA  (PRZY TRASIE E79 - 361.5 km) - 32-064 Rudawa, gm. Zabierzów, krakowski, Małopolskie (Polska) | Małopolskie | krakowski   |

## Summary

- Created postgresql database based on CSV with listings from Otomoto 

- Removed unnecessary columns and created a new table

- Adjusted the data type to the appropriate one for the values in question 

- Adjusted the values to the analytical demand (e.g., converting the engine_displacement column with values like "*1900 cm3*" to the engine_displacement_cm3 column with values like "*1900*"

- Separating from the "generation" column the text value from the year of the beginning and end of a given car generation

- By including an external table with a list of counties and provinces, the ability to extract from the column "location" data about the county and province was obtained

### Continue to Summary Data Analysis [here]([link](https://github.com/m1sti/Car_Offers_Data_Analysis/blob/main/main_data_analysis.md)).
