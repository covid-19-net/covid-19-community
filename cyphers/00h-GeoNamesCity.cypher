USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00h-GeoNamesCity.csv' AS row 
CREATE (c:City:Location{id: row.id})
SET c.name = row.name, c.population = row.population, c.elevation = row.elevation
RETURN count(c) as City
;
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00h-GeoNamesCity.csv' AS row 
MATCH (l:Location{id: row.parentId})
MATCH (c:City{id: row.id})
CREATE (c)-[i:IN]->(l)
RETURN count(i) as IN
;
