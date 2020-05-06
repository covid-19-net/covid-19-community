USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-' + row.date + row.countyFips + row.stateFips})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cummulativeConfirmed = toInteger(row.cummulativeConfirmed), c.cummulativeDeaths = toInteger(row.cummulativeDeaths)
RETURN count(c) as CASE
;
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-' + row.date + row.countyFips + row.stateFips})
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MERGE (c)-[r:REPORTED_IN]->(a)
RETURN count(r) as REPORTED_IN
;
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS 
FROM 'FILE:///02a-JHUCases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-' + row.date + row.countyFips + row.stateFips})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(o) as RELATED_TO
;
