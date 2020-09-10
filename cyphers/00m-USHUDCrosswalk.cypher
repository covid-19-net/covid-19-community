USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToCounty2020Q1.csv' AS row
// adding zip to avoid conflicts with other location ids
MERGE (p:PostalCode:Location{id: 'zip' + row.zip})
SET p.name = row.zip
RETURN count(p) as PostalCode
;
// Note, one Zip code can overlap with multiple counties (Admin2s), e.g. Zip 21771 -> 4 counties
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToCounty2020Q1.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.zip})
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MERGE (p)-[i:IN{id: 'zip_to_admin2-' + row.zip + '-' + row.countyFips}]->(a)
SET i.resRatio = toFloat(row.resRatio), i.busRatio = toFloat(row.busRatio), i.othRatio = toFloat(row.othRatio), i.totRatio = toFloat(row.totRatio)
RETURN count(i) as IN_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToTract2020Q1.csv' AS row
// adding tract to avoid conflicts with other location ids
MERGE (t:Tract:Location{id: 'tract' + row.tract})
SET t.name = row.tract
RETURN count(t) as Tract
;
// Most tracts are defined in 00m-USHUDCrosswalkZipToTract2020Q1.csv, but not all tracts match the ACS 5-year dataset.
// Here we add any missing tracts from the ACS 5-year dataset
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkTractToCounty.csv' AS row
MERGE (t:Tract:Location{id: 'tract' + row.tract})
SET t.name = row.tract
RETURN count(t) as Tract
;
// Note, one Zip code can overlap with multiple Census Tracts
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkZipToTract2020Q1.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.zip})
MATCH (t:Tract{id: 'tract' + row.tract})
//MERGE (t)-[i:IN]->(p)
// Adding these properties on the server takes too long (never completes?)
MERGE (t)-[i:IN{id: 'zip_to_tract-' + row.zip + '-' + row.tract}]->(p)
// Adding these properties on the server takes too long (never completes?)
SET i.resRatio = toFloat(row.resRatio), i.busRatio = toFloat(row.busRatio), i.othRatio = toFloat(row.othRatio), i.totRatio = toFloat(row.totRatio)
RETURN count(i) as IN_TRACT
;
// Most tracts are defined in 00m-USHUDCrosswalkZipToTract2020Q1.csv, but not all tracts match the ACS 5-year dataset.
// Here we add any missing tracts from the ACS 5-year dataset
//USING PERIODIC COMMIT
//LOAD CSV WITH HEADERS 
//FROM 'FILE:///00m-USHUDCrosswalkTractToCounty.csv' AS row
//MERGE (t:Tract:Location{id: 'tract' + row.tract})
//SET t.name = row.tract
//RETURN count(t) as Tract
//;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00m-USHUDCrosswalkTractToCounty.csv' AS row
MATCH (t:Tract{id: 'tract' + row.tract})
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MERGE (t)-[i:IN]->(a)
RETURN count(i) as IN_Admin2
;

                         


