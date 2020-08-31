LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLinkCruiseShip.csv' AS row
MERGE (c:CruiseShip:Location{id: row.geoLocation})
SET c.name = row.geoLocation, c.origLocation = row.origLocation
RETURN count(c) as CruiseShip
;
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLinkCruiseShip.csv' AS row
MATCH (c:CruiseShip{id: row.geoLocation})
MATCH (w:World:Location{id: "m49:1"})
MERGE (c)-[i:IN]->(w)
RETURN count(i) as CRUISESHIP_IN_WORLD
;
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLinkCruiseShip.csv' AS row
MATCH (c:CruiseShip{id: row.geoLocation})
MATCH (s:Strain{origLocation: row.origLocation})
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_CRUISESHIP
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='0'
MATCH (c:Country{name: row.geoName0})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_0
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (c:Country{name: row.geoName0})<-[:IN]-(a:Admin1{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_1_ADMIN1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(a:Admin2{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_1_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (:Country{name: row.geoName0})<-[:IN*1..3]-(c:City{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_1_CITY
;
// If no matches are found above, link by country only
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (c:Country{name: row.geoName0})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_1_COUNTRY
;
//
// Location level 2
//
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(a:Admin2{name: row.geoName2})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_2_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN*1..2]-(c:City{name: row.geoName2})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_2_ADMIN1_CITY
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(:Admin2{name: row.geoName1})<-[:IN]-(c:City{name: row.geoName2})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_2_ADMIN2_CITY
;
// If no matches are found, try linking by without geoName2
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN]-(a:Admin1{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_2_ADMIN1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(a:Admin2{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_2_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (c:Country{name: row.geoName0})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_2_COUNTRY
;
//
// Location level 3
//
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='3'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(:Admin2{name: row.geoName2})<-[:IN]-(c:City{name: row.geoName3})
MATCH (s:Strain{origLocation: row.origLocation})
WHERE NOT (s)-[:FOUND_IN]->()
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_3
;
//
// Link Cases to Locations
//
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLinkCruiseShip.csv' AS row
MATCH (c:CruiseShip{id: row.geoLocation})
MATCH (s:Cases{origLocation: row.origLocation})
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_CRUISESHIP
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='0'
MATCH (c:Country{name: row.geoName0})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_0
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (:Country{name: row.geoName0})<-[:IN]-(a:Admin1{name: row.geoName1})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(a)
RETURN count(h) as REPORTED_IN_1_ADMIN1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(a:Admin2{name: row.geoName1})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(a)
RETURN count(h) as REPORTED_IN_1_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (:Country{name: row.geoName0})<-[:IN*1..3]-(c:City{name: row.geoName1})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_1_CITY
;              
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(a:Admin2{name: row.geoName2})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(a)
RETURN count(h) as REPORTED_IN_2_ADMIN1_ADMIN2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN*1..2]-(c:City{name: row.geoName2})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_ADMIN1_CITY
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(:Admin2{name: row.geoName1})<-[:IN]-(c:City{name: row.geoName2})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_ADMIN2_CITY
;                         
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='3'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(:Admin2{name: row.geoName2})<-[:IN]-(c:City{name: row.geoName3})
MATCH (s:Cases{origLocation: row.origLocation})
WHERE NOT (s)-[:REPORTED_IN]->()
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_3
;

                    

