USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row
MERGE (g:Gene{id: row.id})
SET g.start = toInteger(row.geneStart), g.end = toInteger(row.geneEnd), g.accession = row.geneAccession
RETURN count(g) as Gene
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row 
MERGE (n:GeneName{id: row.id + '-' + row.geneAccession})
SET n.name = row.geneName, n.accession = row.geneAccession
RETURN count(n) as GeneName
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row 
MATCH (g:Gene{id: row.id})
MATCH (n:GeneName{id: row.id + '-' + row.geneAccession}) 
MERGE (g)-[m:NAMED_AS]->(n)
RETURN count(m) as NAMED_AS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row 
MERGE (p:ProteinName{id: row.id + '-' + row.proteinAccession})
SET p.name = row.proteinName, p.accession = row.proteinAccession
RETURN count(p) as ProteinName
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row 
MERGE (p:Protein{id: row.id})
// Only add proteins and properties if they don't exist yet (from UniProt)
ON CREATE SET p.name = row.proteinName, p.accession = row.proteinAccession, p.taxonomyId = row.taxonomyId, p.fullLength = row.fullLength, p.sequence = row.sequence
RETURN count(p) as Protein
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-NCBIGeneProtein.csv' AS row 
MATCH (p:Protein{id: row.id})
MATCH (pn:ProteinName{id: row.id + '-' + row.proteinAccession})
MERGE (p)-[n:NAMED_AS]->(pn)
RETURN count(n) as NAMED_AS
;
