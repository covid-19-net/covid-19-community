USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-ProtCIDInteraction.csv" AS row
MATCH (d1:ProteinDomain{id: row.accession1})
MATCH (d2:ProteinDomain{id: row.accession2})
MERGE (d1)-[i:INTERACTS_WITH{id: row.id}]->(d2)
SET i.source = 'ProtCID', i.interactionType = 'direct interaction'
RETURN count(i) as INTERACTS_WITH
;
LOAD CSV WITH HEADERS FROM "FILE:///01g-ProtCIDInteraction.csv" AS row
MATCH (p:Protein{accession: row.proteinAccession1})<-[:IS_PART_OF_PROTEIN]-(:ProteinDomain{id: row.accession1})
RETURN count(p) as PROTEIN1_IS_PART_OF_DOMAIN1
;
LOAD CSV WITH HEADERS FROM "FILE:///01g-ProtCIDInteraction.csv" AS row
MATCH (p:Protein{accession: row.proteinAccession2})<-[:IS_PART_OF_PROTEIN]-(:ProteinDomain{id: row.accession2})
RETURN count(p) as PROTEIN2_IS_PART_OF_DOMAIN2
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-ProtCIDInteraction.csv" AS row
MATCH (p1:Protein{accession: row.proteinAccession1})<-[:IS_PART_OF_PROTEIN]-(:ProteinDomain{id: row.accession1})
MATCH (p2:Protein{accession: row.proteinAccession2})<-[:IS_PART_OF_PROTEIN]-(:ProteinDomain{id: row.accession2})
MERGE (p1)-[i:INTERACTS_WITH{id:row.id + '_ProtCID'}]->(p2)
SET i.source = 'ProtCID', i.domain1 = row.accession1, i.domain2 = row.accession2,
    i.interactionType = 'direct interaction'
RETURN count(i) as INTERACTS_WITH
;                        
