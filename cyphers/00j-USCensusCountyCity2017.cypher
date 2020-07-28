LOAD CSV WITH HEADERS 
FROM 'FILE:///00j-USCensus2017County.csv' AS row 
MATCH (a:Admin2)-[:IN]->(a1:Admin1{fips: row.stateFips})
WHERE a.id STARTS WITH 'US.' AND a.id ENDS WITH row.fips
SET a.fips = row.fips, a.stateFips = row.stateFips
RETURN count(a) as Admin2_Fips
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00j-USCensus2017City.csv' AS row 
MATCH (c:City{name: row.name})-[:IN]->(:Admin2)-[:IN]->(a1:Admin1{fips: row.stateFips})
SET c.fips = row.fips, c.stateFips = row.stateFips
RETURN count(c) as City_Fips
;
