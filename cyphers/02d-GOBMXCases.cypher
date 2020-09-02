USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02d-GOBMXCasesAdmin1.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-GOBMX' + row.date + '-' + row.origLocation})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cases = toInteger(row.cumulativeCases), 
    c.deaths = toInteger(row.cumulativeDeaths), c.population = toInteger(row.population), 
    c.aggregationLevel = 'Admin1', c.origLocation = row.origLocation,
    c.source = 'GOBMX'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02d-GOBMXCasesAdmin1.csv' AS row
MATCH (c:Cases{id: 'COVID-19-GOBMX' + row.date + '-' + row.origLocation})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02d-GOBMXCasesAdmin2.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-GOBMX' + row.date + '-' + row.origLocation})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cases = toInteger(row.cumulativeCases), 
    c.deaths = toInteger(row.cumulativeDeaths), c.population = toInteger(row.population), 
    c.aggregationLevel = 'Admin2', c.origLocation = row.origLocation,
    c.source = 'GOBMX'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02d-GOBMXCasesAdmin2.csv' AS row
MATCH (c:Cases{id: 'COVID-19-GOBMX' + row.date + '-' + row.origLocation})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;
 