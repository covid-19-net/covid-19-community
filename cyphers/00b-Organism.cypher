LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
MERGE (o:Organism{id: row.id})
SET o.name = row.name, o.scientificName = row.scientificName, o.type = row.type
RETURN count(o) as Organism
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
MATCH (o:Organism{id: row.id})
MATCH (g:Genome{taxonomyId: row.id})
MERGE (o)-[h:HAS_GENOME]->(g)                
RETURN count(h) as HAS_GENOME
;

