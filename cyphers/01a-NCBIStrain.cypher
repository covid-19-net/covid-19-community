LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.id IS null
MERGE (s:Strain{id: row.id})
SET s.name = row.name, s.taxonomyId = row.taxonomy_id, s.collectionDate = date(row.collection_date),
    s.hostTaxonomyId = row.host_taxonomy_id, s.sex = row.sex, s.age = toInteger(row.age), 
    s.isolationSource = row.isolation_source
RETURN count(s) as Strain
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.taxonomy_id IS null
MATCH (p:Pathogen{id: row.taxonomy_id})
MATCH (s:Strain{id: row.id})
MERGE (p)-[h:HAS_STRAIN]->(s)
RETURN count(h) as HAS_STRAIN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-NCBIStrain.csv' AS row 
WITH row WHERE NOT row.host_taxonomy_id IS null
MATCH (h:Host{id: row.host_taxonomy_id})
MATCH (s:Strain{id: row.id})
MERGE (h)-[c:CARRIES]->(s)
RETURN count(c) as CARRIES
;
                
