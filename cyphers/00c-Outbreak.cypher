LOAD CSV WITH HEADERS 
FROM 'FILE:///Outbreak.csv' AS row 
MERGE (o:Outbreak{id: row.id})
SET o.name = row.id, o.startDate = row.startDate, o.pathogen = row.pathogen
RETURN count(o) as Outbreak
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///Outbreak.csv' AS row 
MATCH (p:Organism{id: row.pathogen})
MATCH (o:Outbreak{id: row.id})
MERGE(p)-[c:CAUSES]->(o)
RETURN count(c) as CAUSES
;
                    
