LOAD CSV WITH HEADERS 
FROM 'FILE:///00e-GeoNamesCountry.csv' AS row 
MERGE (c:Country:Location{id: row.id})
SET c.name = row.name, c.iso = row.iso, c.iso3 = row.iso3, c.population = row.population, c.areaSqKm = row.areaSqKm
RETURN count(c) as Country
;
