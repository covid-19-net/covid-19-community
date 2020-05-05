LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Region.csv' AS row 
MERGE (r:USRegion:Location{id: row.id})
SET r.name = row.name
RETURN count(r) as Region
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Division.csv' AS row 
MERGE (d:USDivision:Location{id: row.id})
SET d.name = row.name
RETURN count(d) as Division
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017State.csv' AS row 
MATCH (a:Admin1:Location{name: row.name, country: 'US'})
SET a.fips = row.fips, a.division = row.division
RETURN count(a) as FIPS
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Region.csv' AS row 
MATCH (r:USRegion{id: row.id})
MATCH (c:Country{id: row.parentId})
MERGE (r)-[i:IN]->(c)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Division.csv' AS row 
MATCH (d:USDivision{id: row.id})
MATCH (r:USRegion{id: row.parentId})
MERGE (d)-[i:IN]->(r)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017State.csv' AS row 
MATCH (a:Admin1{name: row.name, country: 'US'})
MATCH (d:USDivision{id: row.parentId})
MERGE (a)-[i:IN]->(d)
RETURN count(i) as IN
;

