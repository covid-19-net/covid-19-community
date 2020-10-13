LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGenome.csv' AS row
WITH row WHERE row.genomeAccession STARTS WITH 'refseq'
MERGE (g:Genome{id: row.genomeAccession})
SET g.name = row.genomeName, g.accession = row.geneAccession, g.taxonomyId = row.taxonomyId
RETURN count(g) as Genome
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGenome.csv' AS row 
WITH row WHERE row.genomeAccession STARTS WITH 'refseq'
MATCH (g:Genome{id: row.genomeAccession})
MATCH (o:Organism{id: row.taxonomyId})
MERGE(o)-[h:HAS_GENOME]->(g)
RETURN count(h) as HAS_GENOME
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGeneProtein.csv' AS row
WITH row WHERE row.genomeAccession STARTS WITH 'refseq'
MERGE (g:Gene{id: row.genomeAccession + '-' + row.geneStart + '-' + row.geneEnd})
SET g.name = row.geneName, g.accession = row.geneAccession, g.start = toInteger(row.geneStart), g.end = toInteger(row.geneEnd), g.genomeAccession = row.genomeAccession
RETURN count(g) as Gene
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGeneProtein.csv' AS row 
WITH row WHERE row.genomeAccession STARTS WITH 'refseq' AND row.fullLength = 'True'
MATCH (gn:Genome{id: row.genomeAccession})
MATCH (g:Gene{id: row.genomeAccession + '-' + row.geneStart + '-' + row.geneEnd})
MERGE(gn)-[h:HAS_GENE]->(g)
RETURN count(h) as HAS_GENE
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGeneProtein.csv' AS row
WITH row WHERE row.genomeAccession STARTS WITH 'refseq'
MERGE (p:Protein{id: row.id})
SET p.name = row.proteinName, p.accession = row.proteinAccession, p.sequence = row.sequence, p.taxonomyId = row.taxonomyId, p.fullLength = row.fullLength
RETURN count(p) as Protein
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGeneProtein.csv' AS row 
MERGE (p:ProteinName{id: row.proteinName + row.proteinAccession})
SET p.name = row.proteinName, p.accession = row.proteinAccession
RETURN count(p) as ProteinName
;
LOAD CSV WITH HEADERS FROM "FILE:///01c-NCBIGeneProtein.csv" AS row
MATCH (p:Protein{id: row.id})
MATCH (pn:ProteinName{id: row.proteinName + row.proteinAccession})
MERGE (p)-[n:NAMED_AS]->(pn)
RETURN count(n) as NAMED_AS
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIGeneProtein.csv' AS row
WITH row  WHERE row.genomeAccession STARTS WITH 'refseq' AND row.fullLength = 'True'
MATCH (g:Gene{id: row.genomeAccession + '-' + row.geneStart + '-' + row.geneEnd})
MATCH (p:Protein{id: row.id})
MERGE(g)-[e:ENCODES]->(p)
RETURN count(e) as ENCODES
;
