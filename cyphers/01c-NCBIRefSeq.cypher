LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (g:Gene{id: row.ncbigeneId + row.start + row.end})
SET g.name = row.gene, g.start = row.start, g.end = row.end
RETURN count(g) as Gene
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (gn:Genome:Strain{id: row.id})
MATCH (g:Gene{id: row.ncbigeneId + row.start + row.end})
MERGE(gn)-[h:HAS]->(g)
RETURN count(h) as Has
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MERGE (p:Protein{id: row.ncbiproteinId})
SET p.name = row.name
RETURN count(p) as Protein
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-NCBIRefSeq.csv' AS row 
MATCH (g:Gene{id: row.ncbigeneId + row.start + row.end})
MATCH (p:Protein{id: row.ncbiproteinId})
MERGE(g)-[e:ENCODES]->(p)
RETURN count(e) as ENCODES
;
