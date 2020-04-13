USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00c-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (s:Strain{id: row.accession})
MERGE (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication
;
