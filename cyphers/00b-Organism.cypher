LOAD CSV WITH HEADERS 
FROM 'FILE:///Organism.csv' AS row 
MERGE (o:Organism{id: row.id})
SET o.name = row.name, o.scientificName = row.scientificName
RETURN count(o) as Organism;
