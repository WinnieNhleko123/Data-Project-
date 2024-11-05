use climate_change;
select * from climate_change_impact_on_agriculture_2024

create table Average_Crop_Yield(
select Country,Crop_type,Year,round(AVG(Crop_Yield_MT_per_HA),2) AS Average_Crop_Yield_MT_per_HA
from climate_change_impact_on_agriculture_2024
group by Country,Crop_type,Crop_Yield_MT_per_HA,Year);
/*Calculating the Average Q1*/

create table Weather_events(
SELECT Country,Year,Extreme_Weather_Events FROM climate_change_impact_on_agriculture_2024
where Extreme_Weather_Events > 0);
/*Identify Countries with Extreme Weather Events Q2*/
                                                                     
create table Top_5(
SELECT Year,Country, CO2_Emissions_MT FROM climate_change_impact_on_agriculture_2024
ORDER BY CO2_Emissions_MT  DESC
LIMIT 5);
/*Find Top 5 Countries by CO2 Emissions Q3*/

create table total_Economic_Impact_Million_USD(
SELECT Region, round(sum(Economic_Impact_Million_USD),2) as total_Economic_Impact_Million_USD
from climate_change_impact_on_agriculture_2024 
where Extreme_Weather_Events
group by Region);
/* Calculate the Total Economic Impact of Extreme Weather Events per Region Q4*/

create table Irrigation_Access(
select County,Year,`Irrigation_Access_%`
from climate_change_impact_on_agriculture_2024 
where `Irrigation_Access_%` < 50);
/*Q5*/
create table Maximum_Fertilizer(
select MAX(Fertilizer_Use_KG_per_HA) as Max_Fertilizer_Use_KG_per_HA
from climate_change_impact_on_agriculture_2024
where Country = `Russia`
order by Fertilizer_Use_KG_per_HA);
/* Find the Year with the Highest Fertilizer Use in a Specific Country Q6*/

create table Average_Temp(
select region, round(AVG(average_temperature_c),2) as avg_temperature
from climate_change_impact_on_agriculture_2024
where year >= year(curdate())-5
group by region);
/* Q7*/
    
create table Total_Pesticide_Use(
SELECT Country, YEAR as Year,
round(SUM(Pesticide_Use_KG_per_HA),2) as Total_Pesticide_Use,
round(SUM(Fertilizer_Use_KG_per_HA),2) as Total_Fertilizer_Use
FROM climate_change_impact_on_agriculture_2024
GROUP BY Country, YEAR);
/*Q9*/

create table correlation_coefficient(
SELECT 
 round((COUNT(*) * SUM(Total_Precipitation_mm * Crop_Yield_MT_per_HA) - SUM(Total_Precipitation_mm) * SUM(Crop_Yield_MT_per_HA)) /
    SQRT((COUNT(*) * SUM(Total_Precipitation_mm * Total_Precipitation_mm) - SUM(Total_Precipitation_mm) * SUM(Total_Precipitation_mm)) * 
          (COUNT(*) * SUM(Crop_Yield_MT_per_HA * Crop_Yield_MT_per_HA) - SUM(Crop_Yield_MT_per_HA) * SUM(Crop_Yield_MT_per_HA))),2) AS correlation_coefficient
FROM climate_change_impact_on_agriculture_2024); 