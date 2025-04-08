SET SQL_SAFE_UPDATES = 0;
UPDATE data
SET
    srcStatename = REPLACE(srcStatename, '0', 'Na'),
    srcDistrictname = REPLACE(srcDistrictname, '0', 'Na'),
    Year = CASE WHEN Year = 'NA' THEN 0 ELSE Year END,
    Country = CASE WHEN Country = 'NA' THEN 'Unknown' ELSE Country END;
   SET SQL_SAFE_UPDATES = 1;

UPDATE data
SET
  TotalFarmersCovered = IFNULL(TotalFarmersCovered, 0),
  ApplicationsLoaneeFarmers = IFNULL(ApplicationsLoaneeFarmers, 0),
  ApplicationsNonLoaneeFarmers = IFNULL(ApplicationsNonLoaneeFarmers, 0),
  InsuredLandArea = IFNULL(InsuredLandArea, 0),
  FarmersPremiumAmount = IFNULL(FarmersPremiumAmount, 0),
  StatePremiumAmount = IFNULL(StatePremiumAmount, 0),
  GOVPremiumAmount = IFNULL(GOVPremiumAmount, 0),
  GrossPremiumAmountToBePaid = IFNULL(GrossPremiumAmountToBePaid, 0),
  SumInsured = IFNULL(SumInsured, 0),
  TotalPopulation = IFNULL(TotalPopulation, 0);
