USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02b-CDSCases.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-CDS' + row.date + '-' + row.origLocation})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.origLocation = row.origLocation, 
    c.cases = toInteger(row.cases), c.deaths = toInteger(row.deaths), c.recovered = toInteger(row.recovered), 
    c.tested = toInteger(row.tested), c.hospitalized = toInteger(row.hospitalized), 
    c.icu = toInteger(row.icu), c.population = toInteger(row.population),
    c.aggregationLevel = row.aggregationLevel,
    c.source = 'CDS'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS 
FROM 'FILE:///02b-CDSCases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-CDS' + row.date + '-' + row.origLocation})
MATCH (o:Outbreak{id: 'COVID-19'})
MERGE (c)-[r:RELATED_TO]->(o)
RETURN count(r) as RELATED_TO
;

 