use assignment;
/*drop table data*/
select * from data
/* SELECTQueries [5 marks]
1. Retrieve the names of all states (srcStateName).
2. RetrieveTotalFarmersCoveredandSumInsuredfor  each  state,  ordered  descending  byTotalFarmersCovered.
*/
 Select srcStateName from data;
 /*2. RetrieveTotalFarmersCoveredandSumInsuredfor  each  state,  ordered  descending  byTotalFarmersCovered.*/
 
SELECT srcStateName, 
       SUM(TotalFarmersCovered) AS TotalFarmersCovered, 
       SUM(SumInsured) AS SumInsured
FROM data
GROUP BY srcStateName
ORDER BY TotalFarmersCovered DESC;

/*Where clause
Retrieve records whereYearis 2020*/

select * from data where YearCode= 2020;

/*Retrieve records whereTotalPopulationRural > 10,00,000andsrcStateName = "HIMACHALPRADESH"*/
select * from data where TotalPopulationRural > 1000000 and srcStateName = "HIMACHALPRADESH";

/*Retrieve the srcStateName,srcDistrictName, and the sum of FarmersPremiumAmount for
 each district in the year 2018, ordered byFarmersPremiumAmount in ascending order.*/
SELECT srcStateName, srcDistrictName, SUM(FarmersPremiumAmount) AS FarmersPremiumAmount
FROM data
WHERE yearcode = 2018
GROUP BY srcStateName, srcDistrictName
ORDER BY FarmersPremiumAmount;

/*Retrieve the total number of farmers covered and the sum of the gross premium 
amount to bepaid for each state where the insured land area is greater than 5.0 for the year 2018*/
select sum(TotalFarmersCovered) as TotalFarmersCovered, sum(GrossPremiumAmountToBePaid)  as GrossPremiumAmountToBePaid
, srcStateName  from data
where YearCode=2018 and InsuredLandArea > 5.0 
group by srcStateName

/* Aggregation*/
/* Calculate averageInsuredLandAreafor each year*/

select  avg(InsuredLandArea) as insuredlandyear , srcYear from data 
 group by srcYear
 
 /*Calculate TotalFarmersCovered for each district where InsuranceUnits > 0 */
 select sum(TotalFarmersCovered) as TotalFarmersCovered, srcDistrictName
 from data 
 where Insuranceunits > 0
 
 /*Calculate total premiums andTotalFarmersCovered for each state where totalSumInsured >5,00,000INR. confused*/
 
 /*IV.  Sorting Data (ORDER BY) [10 marks]
 10. Retrieve the top 5 districts with the highest total population in 2020.
 11. RetrievesrcStateName,srcDistrictName, andSumInsuredfor the 10 districts
 with lowestnon-zero farmers’ premium amount, ordered by insured sum and premium amount.
 12. Retrieve top 3 states for each year with highest insured farmers to total population ratio, orderedby
 the ratio*/
 
 select srcDistrictname, sum(TotalPopulation) as TotalPopulation
 from data
 where YearCode= 2020
 group by srcDistrictname
 order by TotalPopulation desc limit 5;
 
 




 

  


