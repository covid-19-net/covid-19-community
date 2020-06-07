USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.id IS null
MERGE (s:Strain{id: row.id}) 
SET s.name = row.name, s.taxonomyId = row.taxonomyId, s.collectionDate = date(row.collectionDate),
    s.hostTaxonomyId = row.hostTaxonomyId, s.sex = row.sex, s.age = toInteger(row.age), s.clade = row.clade,
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
MATCH (p:Pathogen{id: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (p)-[h:HAS_STRAIN]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.clade IS null
MATCH (s:Strain{id: row.id})
MATCH (c:Clade{id: row.clade})
MERGE (s)-[h:HAS_CLADE]->(c)
RETURN count(h) as HAS_CLADE
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01b-Nextstrain.csv' AS row 
WITH row WHERE NOT row.hostTaxonomyId IS null
MATCH (h:Host{id: row.hostTaxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (h)-[c:CARRIES]->(s)
RETURN count(c) as CARRIES
;
