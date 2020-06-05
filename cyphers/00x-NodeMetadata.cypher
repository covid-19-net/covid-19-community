LOAD CSV WITH HEADERS 
FROM 'FILE:///NodeMetadata.csv' AS row 
MERGE (n:NodeMetadata{name: row.name})
SET n.shortDescription = row.shortDescription, n.description = row.description, n.example = row.example, n.details = row.details
RETURN count(n) as NodeMetadata
;
