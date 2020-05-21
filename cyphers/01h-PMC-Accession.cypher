USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MERGE (p:Publication{id: row.id})
RETURN count(p) as Publication
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (s:Strain{id: row.accession})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication
;
