USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00o-GeoNamesPostalCode.csv' AS row
// adding zip to avoid conflicts with other location ids
MERGE (p:PostalCode:Location{id: 'zip' + row.zip})
SET p.name = row.zip, p.placeName = row.placeName, p.location = point({longitude: toFloat(row.longitude), latitude: toFloat(row.latitude), crs: 'WGS-84'})
RETURN count(p) as PostalCode
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00o-GeoNamesPostalCode.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.zip})
MATCH (a:Admin2{id: row.admin2_id})
MERGE (p)-[i:IN]->(a)
RETURN count(i) as IN_ADMIN2
;