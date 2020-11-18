USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row 
MERGE (s:Strain{id: row.id}) 
SET s.name = row.name, s.accession = row.accession, s.accessions = apoc.convert.toStringList(split(row.accessions, ';')), 
    s.source = row.source, s.taxonomyId = row.taxonomyId, s.hostTaxonomyId = row.hostTaxonomyId, 
    s.sequenceLength = toInteger(row.sequenceLength), s.sequenceQuality = row.sequenceQuality, 
    s.qualityAssessment = row.qualityAssessment, s.collectionDate = date(row.collectionDate),  
    s.origLocation = row.origLocation, s.originatingLab = row.originatingLab
RETURN count(s) as Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (g:Genome{taxonomyId: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (g)-[c:HAS_STRAIN]->(s)
RETURN count(c) as CARRIES
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (p:Pathogen{id: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (p)-[h:HAS_STRAIN]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (h:Host{id: row.hostTaxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (h)-[c:CARRIES]->(s)
RETURN count(c) as CARRIES
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBVariant.csv' AS row
MERGE (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
SET v.name = row.geneVariant, v.geneVariant = row.geneVariant, v.proteinVariant = row.proteinVariant, v.variantType = row.variantType, v.variantConsequence = row.variantConsequence, 
v.start = toInteger(row.start), v.end = toInteger(row.end), v.ref = row.ref, v.alt = row.alt, 
v.taxonomyId = row.taxonomyId, v.referenceGenome = row.referenceGenome, v.proteinPosition = toInteger(row.proteinPosition)
RETURN count(v) as Variant
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBVariant.csv' AS row
MATCH (s:Strain{id: row.id})
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
MERGE (s)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBVariant.csv' AS row
MATCH (g:Gene) 
WHERE g.taxonomyId = row.taxonomyId AND
      toInteger(row.start) >= g.start AND 
      toInteger(row.end) <= g.end
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
MERGE (g)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT_GENE
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBVariant.csv' AS row
MATCH (g:Gene)-[:ENCODES]->(p:Protein)
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
WHERE g.taxonomyId = row.taxonomyId AND
      toInteger(row.start) >= g.start AND 
      toInteger(row.end) <= g.end AND 
      p.start <= v.proteinPosition <= p.end
MERGE (p)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT_PROTEIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBVariant.csv' AS row
MATCH (g:Gene)-[:ENCODES]->(:Protein)-[:CLEAVED_TO]->(p:Protein)
MATCH (v:Variant{id: row.referenceGenome + ':' + row.start + '-' + row.end + '-' + row.ref + '-' + row.alt})
WHERE g.taxonomyId = row.taxonomyId AND
      toInteger(row.start) >= g.start AND 
      toInteger(row.end) <= g.end AND 
      p.start <= v.proteinPosition <= p.end
MERGE (p)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT_CLEAVED_PROTEIN
;


                    

