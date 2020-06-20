USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00g-GeoNamesAdmin2.csv' AS row 
MERGE (a:Admin2:Location{id: row.id})
SET a.name = row.name, a.geonameId = row.geonameId,
a.population = toInteger(row.population), a.elevation = toInteger(row.elevation),
a.location = point({longitude: toFloat(row.longitude), latitude: toFloat(row.latitude), crs: 'WGS-84'})
RETURN count(a) as Admin2
;
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///00g-GeoNamesAdmin2.csv' AS row 
MATCH (a2:Admin2{id: row.id})
MATCH (a1:Admin1{id: row.parentId})
MERGE (a2)-[i:IN]->(a1)
RETURN count(i) as IN
;
