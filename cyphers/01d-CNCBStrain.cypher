USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBStrain.csv' AS row 
MERGE (s:Strain{id: row.id}) 
SET s.name = row.name, s.alias = row.alias, s.taxonomyId = row.taxonomyId, s.collectionDate = date(row.collectionDate), s.hostTaxonomyId = row.hostTaxonomyId, s.location = row.location
RETURN count(s) as Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBStrain.csv' AS row
MATCH (p:Pathogen{id: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (p)-[h:HAS_STRAIN]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBStrain.csv' AS row
MATCH (h:Host{id: row.hostTaxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (h)-[c:CARRIES]->(s)
RETURN count(c) as CARRIES
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01d-CNCBStrain.csv' AS row
WITH row WHERE row.locationLevels='0'
MATCH (c:Country{name: row.country})
MATCH (s:Strain{id: row.id})
MERGE (s)-[f:FOUND_IN]->(c)
RETURN count(f) as FOUND_IN_COUNTRY
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01d-CNCBStrain.csv' AS row
WITH row WHERE row.locationLevels='1'
MATCH (c:Country{name: row.country})<-[:IN*1..2]-(l1:Location{name: row.admin1})
MATCH (s:Strain{id: row.id})
MERGE (s)-[h:FOUND_IN]->(l1)
RETURN count(h) as FOUND_IN_1
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01d-CNCBStrain.csv' AS row
WITH row WHERE row.locationLevels='2'
MATCH (c:Country{name: row.country})<-[:IN*1..2]-(l1:Location{name: row.admin1})<-[:IN*]-(l2:Location{name: row.admin2})
MATCH (s:Strain{id: row.id})
MERGE (s)-[h:FOUND_IN]->(l2)
RETURN count(h) as FOUND_IN_2
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01d-CNCBStrain.csv' AS row
WITH row WHERE row.locationLevels='3'
MATCH (c:Country{name: row.country})<-[:IN]-(l1:Location{name: row.admin1})<-[:IN]-(l2:Location{name: row.admin2})<-[:IN]-(l3:Location{name: row.city})
MATCH (s:Strain{id: row.id})
MERGE (s)-[h:FOUND_IN]->(l3)
RETURN count(h) as FOUND_IN_3
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBVariant.csv' AS row
MERGE (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
SET v.name = row.geneVariant, v.geneVariant = row.geneVariant, v.proteinVariant = row.proteinVariant, v.variantType = row.variantType, v.variantConsequence = row.variantConsequence, 
v.start = toInteger(row.start), v.end = toInteger(row.end), v.ref = row.ref, v.alt = row.alt, 
v.taxonomyId = row.taxonomyId, v.referenceGenome = row.referenceGenome, v.proteinPosition = toInteger(row.proteinPosition)
RETURN count(v) as Variant
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBVariant.csv' AS row
MATCH (s:Strain{name: row.name})
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
MERGE (s)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-CNCBVariant.csv' AS row
MATCH (g:Gene) WHERE toInteger(row.start) >= g.start AND toInteger(row.end) <= g.end
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
MERGE (g)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT
;

                    

