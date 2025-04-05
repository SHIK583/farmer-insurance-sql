SET SQL_SAFE_UPDATES = 0;
UPDATE data
SET
    srcStatename = REPLACE(srcStatename, '0', 'Na'),
    srcDistrictname = REPLACE(srcDistrictname, '0', 'Na'),
    Year = CASE WHEN Year = 'NA' THEN 0 ELSE Year END,
    Country = CASE WHEN Country = 'NA' THEN 'Unknown' ELSE Country END;
   SET SQL_SAFE_UPDATES = 1;

