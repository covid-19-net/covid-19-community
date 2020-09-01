USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///02c-SDHHSACases.csv' AS row 
MERGE (c:Cases{id: 'COVID-19-SDHHSA' + row.date + '-' + row.zipCode})
SET c.name = 'COVID-19-' + row.date, c.date = date(row.date), c.cases = toInteger(row.cases), c.source = 'SDHHSA'
RETURN count(c) as CASES
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///02c-SDHHSACases.csv' AS row
MATCH (c:Cases{id: 'COVID-19-SDHHSA' + row.date + '-' + row.zipCode})
MATCH (p:PostalCode{id: 'zip' + row.zipCode})
MERGE (c)-[r:REPORTED_IN]->(p)
RETURN count(r) as REPORTED_IN
;
