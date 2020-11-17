USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Ids.csv' AS row
MERGE (p:Publication{id: row.id})
SET p.name = row.id
RETURN count(p) as Publication
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01h-PMC-UniProtProtein.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (n:Protein{accession: row.accession, fullLength: 'True'})
MERGE (p)-[m:MENTIONS]->(n)
RETURN count(m) as Publication_Protein
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-CNCBStrain.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (s:Strain{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Genome.csv' AS row
MATCH (p:Publication{id: row.id})                                  
MATCH (g:Genome{refSeq: row.accession})
MERGE (p)-[m:MENTIONS]->(g)
RETURN count(m) as Publication_Genome
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-PDBStructures.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (s:Structure{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_Structure
;