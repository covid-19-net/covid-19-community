LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Region.csv' AS row 
CREATE (r:Region:Location{id: row.id})
SET r.name = row.name
RETURN count(r) as Region
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Division.csv' AS row 
CREATE (d:Division:Location{id: row.id})
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
MATCH (r:Region{id: row.id})
MATCH (c:Country{id: row.parentId})
CREATE (r)-[i:IN]->(c)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017Division.csv' AS row 
MATCH (d:Division{id: row.id})
MATCH (r:Region{id: row.parentId})
CREATE (d)-[i:IN]->(r)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00i-USCensus2017State.csv' AS row 
MATCH (a:Admin1{name: row.name, country: 'US'})
MATCH (d:Division{id: row.parentId})
CREATE (a)-[i:IN]->(d)
RETURN count(i) as IN
;

