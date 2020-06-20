LOAD CSV WITH HEADERS 
FROM 'FILE:///00e-GeoNamesCountry.csv' AS row 
MERGE (c:Country:Location{id: row.id})
SET c.name = row.name, c.iso = row.iso, c.iso3 = row.iso3, c.geonameId = row.geonameId, c.areaSqKm = toInteger(row.areaSqKm), c.population = toInteger(row.population),
c.location = point({longitude: toFloat(row.longitude), latitude: toFloat(row.latitude), crs: 'WGS-84'})
RETURN count(c) as Country
;
