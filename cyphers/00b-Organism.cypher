LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
WITH row WHERE row.type='host'
MERGE (h:Host{id: row.id})
SET h.name = row.name, h.scientificName = row.scientificName
RETURN count(h) as Host
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
WITH row WHERE row.type='pathogen'
MERGE (p:Pathogen{id: row.id})
SET p.name = row.name, p.scientificName = row.scientificName
RETURN count(p) as Pathogen
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
MERGE (o:Organism{id: row.id})
SET o.name = row.name, o.scientificName = row.scientificName, o.type = row.type
RETURN count(o) as Organism
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
WITH row WHERE row.type='host'
MATCH (h:Host{id: row.id})
MATCH (o:Organism{id: row.id})
MERGE (h)-[i:IS_A]->(o)
RETURN count(i) as IS_A
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
WITH row WHERE row.type='pathogen'
MATCH (p:Pathogen{id: row.id})
MATCH (o:Organism{id: row.id})
MERGE (p)-[i:IS_A]->(o)
RETURN count(i) as IS_A
;

