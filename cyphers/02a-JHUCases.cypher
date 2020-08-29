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
FROM 'FILE:///02a-JHUCasesGlobal.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.origLocation})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths), c.source = 'JHU',
c.origLocation = row.origLocation
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCasesGlobal.csv' AS row
MATCH (c:Cases{id: 'COVID-19-JHU' + row.date + '-' + row.origLocation})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
 