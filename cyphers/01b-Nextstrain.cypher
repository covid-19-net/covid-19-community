USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.id IS null
CREATE (s:Genome:Strain{id: row.id}) 
SET s.name = row.name, s.alias = row.alias, s.taxonomy = row.taxonomy_id, s.collectionDate = row.collection_date,
    s.hostTaxonomyId = row.host_taxonomy_id, s.sex = row.sex, s.age = row.age, s.clade = row.clade,
    s.countryExposure = row.country_exposure, s.admin1Exposure = row.admin1_exposure
RETURN count(s) as Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.clade IS null
MERGE (c:Clade{id: row.clade})
RETURN count(c) as Clade
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.taxonomy_id IS null
MATCH (o:Organism{id: row.taxonomy_id})
MATCH (s:Strain{id: row.id})
CREATE (o)-[h:HAS]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.clade IS null
MATCH (s:Strain{id: row.id})
MATCH (c:Clade{id: row.clade})
CREATE (s)-[h:HAS]->(c)
RETURN count(h) as HAS_CLADE
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.host_taxonomy_id IS null
MATCH (o:Organism{id: row.host_taxonomy_id})
MATCH (s:Strain{id: row.id})
CREATE (o)-[h:CARRIES]->(s)
RETURN count(h) as CARRIES
;
