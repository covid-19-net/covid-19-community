LOAD CSV WITH HEADERS 
FROM 'FILE:///Genome.csv' AS row 
MERGE (g:Genome{id: row.assemblyAccession})
SET g.name = row.name, g.refSeq = row.refSeq, g.genomeAccession = row.genomeAccession, 
    g.taxonomyId = row.taxonomyId
RETURN count(g) as Genome
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Genome.csv' AS row 
MERGE (c:Chromosome{id: row.genomeAccession})
SET c.name = row.chromosome, c.genomeAccession = row.genomeAccession, c.refSeq = row.refSeq, c.taxonomyId = row.taxonomyId
RETURN count(c) as Chromosome
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Genome.csv' AS row 
MATCH (g:Genome{id: row.assemblyAccession})
MATCH (c:Chromosome{id: row.genomeAccession})
MERGE (g)-[h:HAS_CHROMOSOME]->(c)                
RETURN count(h) as HAS_CHROMOSOME
;

