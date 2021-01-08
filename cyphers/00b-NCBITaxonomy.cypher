USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-NCBITaxonomy.csv' AS row 
MERGE (o:Organism{id: row.id})
SET o.name = row.name, o.scientificName = row.scientificName, o.synonymes = row.synonymes, o.rank = row.rank, o.division = row.division
RETURN count(o) as Organism
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-NCBITaxonomy.csv' AS row 
MATCH (o1:Organism{id: row.id})
MATCH (o2:Organism{id: row.parentId}) 
MERGE (o1)-[h:IS_A]->(o2)
RETURN count(h) as IS_A
;

