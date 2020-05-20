USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.id IS null
MERGE (s:Genome:Strain{id: row.id}) 
SET s.name = row.name, s.taxonomyId = row.taxonomyId, s.collectionDate = row.collectionDate,
    s.hostTaxonomyId = row.hostTaxonomyId, s.sex = row.sex, s.age = row.age, s.clade = row.clade,
    s.exposureCountry = row.exposureCountry, s.exposureAdmin1 = row.exposureAdmin1
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
WITH row WHERE NOT row.taxonomyId IS null
MATCH (o:Organism{id: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (o)-[h:HAS]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.clade IS null
MATCH (s:Strain{id: row.id})
MATCH (c:Clade{id: row.clade})
MERGE (s)-[h:HAS]->(c)
RETURN count(h) as HAS_CLADE
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.hostTaxonomyId IS null
MATCH (o:Organism{id: row.hostTaxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (o)-[h:CARRIES]->(s)
RETURN count(h) as CARRIES
;
