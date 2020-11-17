USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtGene.csv' AS row 
MERGE (g:Gene{id: row.id})
SET g.name = row.name, g.synonymes = row.synomymes, g.taxonomyId = row.taxonomyId, g.chromosome = row.chromosome
RETURN count(g) as Gene
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtGene.csv' AS row 
MATCH (g:Gene{id: row.id})
WITH g, row
UNWIND split(row.synonymes, ';') AS name
MERGE (n:GeneName{id: row.id + '-' + row.name})
SET n.name = row.name
RETURN count(n) as GeneName
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtGene.csv' AS row 
MATCH (g:Gene{id: row.id})
MATCH (n:GeneName{id: row.id + '-' + row.name}) 
MERGE (g)-[m:NAMED_AS]->(n)
RETURN count(m) as NAMED_AS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtGene.csv' AS row
MATCH (g:Gene{id: row.id})
MATCH (c:Chromosome{name: row.chromosome, taxonomyId: row.taxonomyId})
MERGE (c)-[h:HAS_GENE]->(g)                
RETURN count(h) as HAS_GENE
;
