use assignment;
/*drop table data*/
select * from data
/* SELECTQueries [5 marks]
1. Retrieve the names of all states (srcStateName).
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
 */
 select srcDistrictname, sum(TotalPopulation) as TotalPopulation
 from data
 where YearCode= 2020
 group by srcDistrictname
 order by TotalPopulation desc limit 5;
 
 /* 11. Retrieve srcStateName,srcDistrictName, andSumInsured for the 10 districts
 with lowest non-zero farmers’ premium amount, ordered by insured sum and premium amount.*/
 
Select srcStateName,srcDistrictName,FarmersPremiumAmount,SumInsured
from data
where FarmersPremiumAmount is not Null and FarmersPremiumAmount > 0
order by SumInsured, FarmersPremiumAmount limit 10;

/*Retrieve top 3 states for each year with highest insured farmers to total population ratio, orderedby
 the ratio*/
select srcStateName, srcYear, sum(SumInsured) as SumInsured, sum(totalpopulation) as totalpopulation,
ROUND(SUM(SumInsured) / SUM(TotalPopulation), 3) AS total_population_ratio
 from data
 WHERE 
    TotalPopulation > 0 
 group by srcYear, srcStateName
 order by total_population_ratio desc limit 3;
 
 /*String Functions [6 marks]13. 
 Retrieve the first 3 characters of the srcStateName to create StateShortName.*/
 
 Select substr(srcStateName,1, 3) as StateShortName  from data;
 /*14. Retrieve srcDistrictName where the district name starts with"B".*/
 
 select srcDistrictName from data where srcDistrictName  like "B%";
 /* 15. Retrieve srcStateNameandsrcDistrictNamewhere district name ends with"pur"*/
 select srcStateName, srcDistrictName from data  where    srcDistrictName like "%pur";
 
 /*joins [14 marks]16. 
 INNER JOINsrcStateNameandsrcDistrictNameto retrieve the aggregated farmers’ premiumamount for districts 
 where the Insurance units for an individual year are greater than 10.
 */
 
 select d1.srcStateName, d1.srcDistrictName, d1.srcYear, SUM(d2.FarmersPremiumAmount) AS TotalFarmersPremium
 from data d1
Inner  join data d2
 on d1.srcStateName=d2.srcStateName
 and d1.srcDistrictName=d1.srcDistrictName  and
d1.srcYear=d2.srcYear
where d1.Insuranceunits>10
group by d1.srcStateName, d1.srcDistrictName, d1.srcYear;
 
/* 17. RetrievesrcStateName,srcDistrictName,Year,TotalPopulationfor each district and thethe 
 highest recorded farmers premium amount for that district over all available years. 
 Returnonly those districts where the highest amount exceeds 20 crores.*/
-- Subquery to get max FarmersPremiumAmount per district
SELECT 
    d.srcStateName,
    d.srcDistrictName,
    d.srcYear,
    d.TotalPopulation,
    d.FarmersPremiumAmount AS MaxFarmersPremium
FROM data d
JOIN (
    SELECT 
        srcStateName,
        srcDistrictName,
        MAX(FarmersPremiumAmount) AS MaxPremium
    FROM data
    GROUP BY srcStateName, srcDistrictName
    HAVING MaxPremium > 200000000
) AS max_table
ON d.srcStateName = max_table.srcStateName
   AND d.srcDistrictName = max_table.srcDistrictName
   AND d.FarmersPremiumAmount = max_table.MaxPremium;
   
   /*18. Perform a LEFT JOIN 
 to combine the total population statistics with the farmers’ data for eachdistrict and state. 
 Return the total premium amount and the average population count for eachdistrict aggregated over the
 years, where the total premium amount is greater than 100 crores.Sort the results by total farmers’ 
 premium amount, highest first.*/
   
   SELECT 
    d.srcStateName,
    d.srcDistrictName,
    SUM(d.FarmersPremiumAmount) AS TotalFarmersPremium,
    AVG(d.TotalPopulation) AS AvgPopulation
FROM data d
LEFT JOIN data pop
    ON TRIM(d.srcStateName) = TRIM(pop.srcStateName)
    AND TRIM(d.srcDistrictName) = TRIM(pop.srcDistrictName)
GROUP BY d.srcStateName, d.srcDistrictName
HAVING TotalFarmersPremium > 100000000
ORDER BY TotalFarmersPremium DESC;

/*19. Districts where total farmers covered is greater than average total farmers 
covered across all records:*/
select srcDistrictName from data where TotalFarmersCovered >
(select avg(TotalFarmersCovered) from data);

/*Find srcStateName where insured sum is higher than 
insured sum of the district with the highestfarmers’ premium amount*/
SELECT srcStateName
FROM data
WHERE SumInsured > (
    SELECT MAX(SumInsured)
    FROM data
    WHERE FarmersPremiumAmount = (
        SELECT MAX(FarmersPremiumAmount)
        FROM data
    )
);
/*FindsrcDistrictNamewhere farmers’ premium amount is higher than average farmers’ premiumamount of the state with highest total population.*/

SELECT srcDistrictName, srcStateName, FarmersPremiumAmount
FROM data
WHERE FarmersPremiumAmount > (
    SELECT AVG(FarmersPremiumAmount)
    FROM data
    WHERE srcStateName = (
        SELECT srcStateName
        FROM data
        GROUP BY srcStateName
        ORDER BY SUM(TotalPopulation) DESC
        LIMIT 1
    )
);

/*advanced SQL Functions (Window Functions) [10 marks]22. UseROW_NUMBER()to rank records ordered by the
 total farmers covered.
 */
 
 SELECT 
    srcStateName,
    srcDistrictName,
    TotalFarmersCovered,
    ROW_NUMBER() OVER (ORDER BY TotalFarmersCovered DESC) AS row_rank
FROM data;
/*23. UseRANK()to rank districts based on insured sum partitioned bysrcStateName.*/
SELECT 
    srcStateName,
    srcDistrictName,
    SumInsured,
    RANK() OVER (PARTITION BY srcStateName ORDER BY SumInsured DESC) AS state_rank
FROM data;
/*24. UseSUM()window function to calculate cumulative farmers’
 premium amount for each districtpartitioned bysrcStateName*/
SELECT 
    srcStateName,
    srcDistrictName,
    srcYear,
    FarmersPremiumAmount,
    SUM(FarmersPremiumAmount) OVER (PARTITION BY srcStateName, srcDistrictName ORDER BY srcYear) AS cumulative_premium
FROM data;

/*Data Integrity (Constraints, Foreign Keys) [4 marks]25. Create a tabledistrictswithDistrictCodeas the primary key and columns forDistrictNameandStateCode. Create another tablestateswithStateCodeas primary key and column forStateName.2
26. Add a foreign key constraint to the districts table referencingStateCodefrom the states table.*/

CREATE TABLE states (
    StateCode VARCHAR(10) PRIMARY KEY,
    StateName VARCHAR(100) NOT NULL
);

CREATE TABLE districts (
    DistrictCode VARCHAR(10) PRIMARY KEY,
    DistrictName VARCHAR(100) NOT NULL,
    StateCode VARCHAR(10),
    FOREIGN KEY (StateCode) REFERENCES states(StateCode)
);

/*UPDATEandDELETE[6 marks]
27. Update FarmersPremiumAmountto 500.0 INR whererowID = 1.28.*/
 update data 
 set FarmersPremiumAmount = 500.0
 where rowID = 1.28;
 
 set SQL_SAFE_UPDATES= 0;
 /*Update year to 2021 for records wheresrcStateName = "HIMACHAL PRADESH".*/
 update data
 set srcYear=2021
 where srcStateName = "HIMACHAL PRADESH";
 /* 29. Delete records whereTotalFarmersCovered < 10,000andYear = 2020*/
 delete from data
 where TotalFarmersCovered < 10000 and srcYear = 2020;
 set SQL_SAFE_UPDATES= 1;

 
 










   



 
 
   


 
 




 

  


