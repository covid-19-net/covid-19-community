USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MERGE (p:Publication{id: row.id})
SET p.name = row.id
RETURN count(p) as Publication
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (g:Genome{id: row.accession})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(g)
RETURN count(m) as Publication_Genome
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (s:Strain{id: row.accession})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_Strain
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (n:Protein{fullLength: 'True'})-[:NAMED_AS]->(:ProteinName{accession: row.accession})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(n)
RETURN count(m) as Publication_Protein
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Accession.csv' AS row
WITH row WHERE NOT row.accession IS null
MATCH (s:Structure{id: row.accession})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_Structure
;