USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row 
MERGE (s:Strain{id: row.id}) 
SET s.name = row.name, s.accession = row.accession, s.accessions = apoc.convert.toStringList(split(row.accessions, ';')), 
    s.source = row.source, s.taxonomyId = row.taxonomyId, s.hostTaxonomyId = row.hostTaxonomyId, 
    s.lineage = row.lineage, s.sequenceLength = toInteger(row.sequenceLength), 
    s.completeness = row.completeness, 
//  s.gender = row.gender, s.age = row.age,
    s.sequenceQuality = row.sequenceQuality, s.qualityAssessment = row.qualityAssessment,
    s.collectionDate = date(row.collectionDate),  
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
MATCH (p:Organism{id: row.taxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (p)-[h:HAS_STRAIN]->(s)
RETURN count(h) as HAS_STRAIN
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (h:Organism{id: row.hostTaxonomyId})
MATCH (s:Strain{id: row.id})
MERGE (h)-[c:CARRIES]->(s)
RETURN count(c) as CARRIES
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (o1:Organism{id: row.taxonomyId})
MATCH (o2:Organism{id: row.hostTaxonomyId})
MERGE (o1)-[h:HAS_HOST]->(o2)
RETURN count(h) as HAS_HOST
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBLineage.csv' AS row
MERGE (l:Lineage{id: row.lineage})
SET l.name = row.lineage, l.count = row.count, l.source = row.source, l.software = row.software
RETURN count(l) as Lineage
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBStrain.csv' AS row
MATCH (s:Strain{id: row.id})
MATCH (l:Lineage{id: row.lineage})
MERGE (s)-[h:HAS_LINEAGE]->(l)
RETURN count(h) as HAS_LINEAGE
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 2
MERGE (l1:Lineage{id: row.l1})
MERGE (l0:Lineage{id: row.l0})
MERGE (l1)-[i:IS_A]->(l0)
RETURN count(i) as IS_A
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 3
MERGE (l2:Lineage{id: row.l2})
MERGE (l1:Lineage{id: row.l1})
MERGE (l2)-[i:IS_A]->(l1)
RETURN count(i) as IS_A
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 4
MERGE (l3:Lineage{id: row.l3})
MERGE (l2:Lineage{id: row.l2})
MERGE (l3)-[i:IS_A]->(l2)
RETURN count(i) as IS_A
; 
LOAD CSV WITH HEADERS 
FROM 'FILE:///01c-CNCBLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 5
MERGE (l4:Lineage{id: row.l4})
MERGE (l3:Lineage{id: row.l3})
MERGE (l4)-[i:IS_A]->(l3)
RETURN count(i) as IS_A
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
FROM 'FILE:///01c-CNCBStrainVariant.csv' AS row
MATCH (s:Strain{id: row.accession})
MATCH (v:Variant{id: row.id})
MERGE (s)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT
;
MATCH (g:Gene{taxonomyId: 'taxonomy:2697049', reviewed: 'True'}) 
MATCH (v:Variant)
WHERE v.start >= g.start AND v.end <= g.end
MERGE (g)-[h:HAS_VARIANT]->(v)
RETURN count(h) as HAS_VARIANT_GENE
;
MATCH (v:Variant)<-[:HAS_VARIANT]-(g:Gene)-[:ENCODES]->(p:Protein)
WHERE p.start <= v.proteinPosition <= p.end
MERGE (p)-[h:HAS_VARIANT]->(v)
WITH p, v
MATCH (p)-[:CLEAVED_TO]->(pc:Protein)
WHERE pc.start <= v.proteinPosition <= pc.end
MERGE (pc)-[hc:HAS_VARIANT]->(v)
RETURN count(hc) as HAS_VARIANT_CLEAVED_PROTEIN
;



                    

