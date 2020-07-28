USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.stateFips + row.countyFips})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths), c.source = 'JHU'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.stateFips + row.countyFips})
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MERGE (c)-[r:REPORTED_IN]->(a)
RETURN count(r) as REPORTED_IN
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.stateFips + row.countyFips})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCountry.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths), c.source = 'JHU'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCountry.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country})
MATCH (cn:Country{name: row.country})
MERGE (c)-[r:REPORTED_IN]->(cn)
RETURN count(r) as REPORTED_IN
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCountry.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalAdmin1.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country + row.admin1})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths), c.source = 'JHU'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalAdmin1.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country + row.admin1})
MATCH (a:Admin1{name: row.admin1})-[:IN]->(:Country{name: row.country})
MERGE (c)-[r:REPORTED_IN]->(a)
RETURN count(r) as REPORTED_IN
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalAdmin1.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.country + row.admin1})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCruiseShip.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.cruiseship})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths), c.source = 'JHU'
RETURN count(c) as CASES
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCruiseShip.csv' AS row 
MERGE (cs:CruiseShip:Location{id: row.cruiseship})
SET cs.name = row.cruiseship
RETURN count(cs) as CRUISESHIP
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCruiseShip.csv' AS row 
MATCH (cs:CruiseShip:Location{id: row.cruiseship})
MATCH (w:World{id: "m49:1"})
MERGE (cs)-[i:IN]->(w)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCruiseShip.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' +  row.cruiseship})
MATCH (cs:CruiseShip{id: row.cruiseship})
MERGE (c)-[r:REPORTED_IN]->(cs)
RETURN count(r) as REPORTED_IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobalCruiseShip.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.cruiseship})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
 