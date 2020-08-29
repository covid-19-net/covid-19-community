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
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_0
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (c:Country{name: row.geoName0})<-[:IN*1..3]-(a:Location{name: row.geoName1})
MATCH (s:Strain{origLocation: row.origLocation})
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(:Location{name: row.geoName1})<-[:IN*1..2]-(a:Location{name: row.geoName2})
MATCH (s:Strain{origLocation: row.origLocation})
MERGE (s)-[h:FOUND_IN]->(a)
RETURN count(h) as FOUND_IN_2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='3'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(:Admin2{name: row.geoName2})<-[:IN]-(c:City{name: row.geoName3})
MATCH (s:Strain{origLocation: row.origLocation})
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_3
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='0'
MATCH (c:Country{name: row.geoName0})
MATCH (s:Strain{origLocation: row.origLocation})
MERGE (s)-[h:FOUND_IN]->(c)
RETURN count(h) as FOUND_IN_0
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
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_0
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (c:Country{name: row.geoName0})<-[:IN*1..3]-(a:Location{name: row.geoName1})
MATCH (s:Cases{origLocation: row.origLocation})
MERGE (s)-[h:REPORTED_IN]->(a)
RETURN count(h) as REPORTED_IN_1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (:Country{name: row.geoName0})<-[:IN*1..2]-(:Location{name: row.geoName1})<-[:IN*1..2]-(a:Location{name: row.geoName2})
MATCH (s:Cases{origLocation: row.origLocation})
MERGE (s)-[h:REPORTED_IN]->(a)
RETURN count(h) as REPORTED_IN_2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///10a-GeoLink.csv' AS row
WITH row WHERE row.locationLevels='3'
MATCH (:Country{name: row.geoName0})<-[:IN]-(:Admin1{name: row.geoName1})<-[:IN]-(:Admin2{name: row.geoName2})<-[:IN]-(c:City{name: row.geoName3})
MATCH (s:Cases{origLocation: row.origLocation})
MERGE (s)-[h:REPORTED_IN]->(c)
RETURN count(h) as REPORTED_IN_3
;

                    

