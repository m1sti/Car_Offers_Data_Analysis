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