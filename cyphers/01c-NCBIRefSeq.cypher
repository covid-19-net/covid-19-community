LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (g:Gene{id: row.geneAccession + '-' + row.geneStart + '-' + row.geneEnd})
SET g.name = row.geneName, g.start = toInteger(row.geneStart), g.end = toInteger(row.geneEnd)
RETURN count(g) as Gene
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (gn:Strain{id: row.strainId})
MATCH (g:Gene{id: row.geneAccession + '-' + row.geneStart + '-' + row.geneEnd})
MERGE(gn)-[h:HAS]->(g)
RETURN count(h) as Has
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (p:Protein{id: row.id})
SET p.name = row.proteinName, p.accession = row.proteinAccession, p.sequence = row.sequence, p.taxonomyId = row.taxonomyId
RETURN count(p) as Protein
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (p:ProteinName{id: row.proteinName + row.proteinAccession})
SET p.name = row.proteinName, p.accession = row.proteinAccession
RETURN count(p) as ProteinName
;
LOAD CSV WITH HEADERS FROM "FILE:///01c-NCBIRefSeq.csv" AS row
MATCH (p:Protein{id: row.id})
MATCH (pn:ProteinName{id: row.proteinName + row.proteinAccession})
MERGE (p)-[n:NAMED_AS]->(pn)
RETURN count(n) as NAMED_AS
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (g:Gene{id: row.geneAccession + '-' + row.geneStart + '-' + row.geneEnd})
MATCH (p:Protein{id: row.id})
MERGE(g)-[e:ENCODES]->(p)
RETURN count(e) as ENCODES
;
