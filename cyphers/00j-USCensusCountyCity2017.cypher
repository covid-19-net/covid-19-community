LOAD CSV WITH HEADERS 
FROM 'FILE:///00j-USCensus2017County.csv' AS row 
MERGE (a:Admin2:Location{name: row.name})-[:IN]->(a1:Admin1{fips: row.stateFips})
SET a.fips = row.fips, a.stateFips = row.stateFips, a.geoId = row.geoId
RETURN count(a) as Admin2_Fips
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00j-USCensus2017City.csv' AS row 
MERGE (c:City:Location{name: row.name})-[:IN]->(:Admin2)-[:IN]->(a1:Admin1{fips: row.stateFips})
SET c.fips = row.fips, c.stateFips = row.stateFips
RETURN count(c) as City_Fips
;
