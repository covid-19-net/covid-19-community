LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.id IS null
MERGE (s:Genome:Strain{id: row.id})
SET s.name = row.name, s.taxonomy = row.taxonomy_id, s.collectionDate = row.collection_date,
    s.hostTaxonomyId = row.host_taxonomy_id, s.sex = row.sex, s.age = row.age, 
    s.isolationSource = row.isolation_source
RETURN count(s) as Strain
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.taxonomy_id IS null
MATCH (o:Organism{id: row.taxonomy_id})
MATCH (s:Strain{id: row.id})
MERGE (o)-[h:HAS]->(s)
RETURN count(h) as HAS
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.host_taxonomy_id IS null
MATCH (o:Organism{id: row.host_taxonomy_id})
MATCH (s:Strain{id: row.id})
MERGE (o)-[h:CARRIES]->(s)
RETURN count(h) as CARRIES
;
                
