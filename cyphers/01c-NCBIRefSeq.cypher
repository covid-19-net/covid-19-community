LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (g:Gene{id: row.ncbigene_id})
SET g.name = row.gene, g.start = row.start, g.end = row.end
RETURN count(g) as Gene
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (gn:Genome:Strain{id: row.genbank_id})
MATCH (g:Gene{id: row.ncbigene_id})
MERGE(gn)-[h:HAS]->(g)
RETURN count(h) as Has
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (p:Protein{id: row.ncbiprotein_id})
SET p.name = row.product
RETURN count(p) as Protein
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (g:Gene{id: row.ncbigene_id})
MATCH (p:Protein{id: row.ncbiprotein_id})
MERGE(g)-[e:ENCODES]->(p)
RETURN count(e) as ENCODES
;
