LOAD CSV WITH HEADERS 
FROM 'FILE:///00j-USCensus2017County.csv' AS row 
MERGE (a:Admin2:Location{name: row.name})-[:IN]->(a1:Admin1{fips: row.stateFips})
SET a.fips = row.fips, a.stateFips = row.stateFips
RETURN count(a) as Admin2
;

