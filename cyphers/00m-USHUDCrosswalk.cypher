LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkCountyToZip2020Q1.csv' AS row
// adding zip to avoid conflicts with other location ids
MERGE (p:PostalCode:Location{id: 'zip' + row.zip})
SET p.name = row.zip
RETURN count(p) as PostalCode
;
// Note, one Zip code can overlap with multiple counties (Admin2s), e.g. Zip 21771 -> 4 counties
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToCounty2020Q1.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.zip})
MATCH (a:Admin2{geoId: row.countyFips})
MERGE (p)-[i:IN{id: 'zip_to_admin2-' + row.zip + '-' + row.countyFips}]->(a)
SET i.resRatio = toFloat(row.resRatio), i.busRatio = toFloat(row.busRatio), i.othRatio = toFloat(row.othRatio), i.totRatio = toFloat(row.totRatio)
RETURN count(i) as IN_ADMIN2
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToTract2020Q1.csv' AS row
// adding zip to avoid conflicts with other location ids
MERGE (t:Tract:Location{id: 'tract' + row.tract})
SET t.name = row.tract
RETURN count(t) as Tract
;
// Note, one Zip code can overlap with multiple Census Tracts
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToTract2020Q1.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.zip})
MATCH (t:Tract{id: 'tract' + row.tract})
MERGE (t)-[i:IN{id: 'zip_to_tract-' + row.zip + '-' + row.tract}]->(p)
SET i.resRatio = toFloat(row.resRatio), i.busRatio = toFloat(row.busRatio), i.othRatio = toFloat(row.othRatio), i.totRatio = toFloat(row.totRatio)
RETURN count(i) as IN_TRACT
;
//LOAD CSV WITH HEADERS 
//FROM 'FILE:///00m-USHUDCrosswalkCountyToZip2020Q1.csv' AS row
//MATCH (z:Zip{id: 'zip' + row.zip})
//MATCH (a:Admin2{geoId: row.countyFips})
//MERGE (a)-[i:IN{id: 'admin2_to_zip-' + row.countyFips + '-' + row.zip}]->(z)
//SET i.resRatio = toFloat(row.resRatio), i.busRatio = toFloat(row.busRatio), i.othRatio = toFloat(row.othRatio), i.totRatio = toFloat(row.totRatio)
//RETURN count(i) as IN_ZIP
//;
                         


