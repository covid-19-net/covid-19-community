USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00h-GeoNamesCity.csv' AS row 
MERGE (c:City:Location{id: row.id})
SET c.name = row.name, c.population = toInteger(row.population), c.elevation = toInteger(row.elevation)
RETURN count(c) as City
;
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00h-GeoNamesCity.csv' AS row 
MATCH (l:Location{id: row.parentId})
MATCH (c:City{id: row.id})
MERGE (c)-[i:IN]->(l)
RETURN count(i) as IN
;
