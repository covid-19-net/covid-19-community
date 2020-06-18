LOAD CSV WITH HEADERS 
FROM 'FILE:///DataProvider.csv' AS row 
MERGE (d:DataProvider{id: row.id})
SET d.id = row.id, d.name = row.name, d.url = row.url, d.license = row.license
RETURN count(d) as DataProvider
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///NodeMetadata.csv' AS row 
UNWIND split(row.dataProviders, ';') AS dp
MATCH (d:DataProvider{id: dp})
MATCH (n:NodeMetadata{name: row.name})
MERGE (n)-[u:USES_DATA_FROM]->(d)
RETURN count(u) as USES_DATA_FROM
;