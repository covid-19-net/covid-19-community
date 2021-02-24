USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE (NOT row.proIdA IS NULL) AND (NOT row.proIdB IS NULL)
MATCH (pa:Protein{proId: row.proIdA})
MATCH (pb:Protein{proId: row.proIdB})
MERGE (pa)-[i:INTERACTS_WITH{id:row.interactionId}]->(pb)
SET i.interactionIds = row.interactionIds,
    i.interactionType = row.interactionType, i.detectionMethod = row.detectionMethod,
    i.confidenceValue = toFloat(row.confidenceValue), i.pubmedId = row.pubmedId,
    i.source = 'IntAct'
RETURN count(i) as INTERACTS_WITH
;
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE (NOT row.proIdA IS NULL) AND row.proIdB IS NULL 
MATCH (pa:Protein{proId: row.proIdA})
MATCH (pb:Protein{accession: row.accessionB})
WHERE pb.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH{id:row.interactionId}]->(pb)
SET i.interactionIds = row.interactionIds,
    i.interactionType = row.interactionType, i.detectionMethod = row.detectionMethod,
    i.confidenceValue = toFloat(row.confidenceValue), i.pubmedId = row.pubmedId,
    i.source = 'IntAct'
RETURN count(i) as INTERACTS_WITH
;
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE row.proIdA IS NULL AND (NOT row.proIdB IS NULL)
MATCH (pa:Protein{accession: row.accessionA})
MATCH (pb:Protein{proId: row.proIdB})
WHERE pa.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH{id:row.interactionId}]->(pb)
SET i.interactionIds = row.interactionIds,
    i.interactionType = row.interactionType, i.detectionMethod = row.detectionMethod,
    i.confidenceValue = toFloat(row.confidenceValue), i.pubmedId = row.pubmedId,
    i.source = 'IntAct'
RETURN count(i) as INTERACTS_WITH
;                 
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE row.proIdA IS NULL AND row.proIdB IS NULL
MATCH (pa:Protein{accession: row.accessionA})
MATCH (pb:Protein{accession: row.accessionB})
WHERE pa.fullLength = 'True' AND pb.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH{id:row.interactionId}]->(pb)
SET i.interactionIds = row.interactionIds,
    i.interactionType = row.interactionType, i.detectionMethod = row.detectionMethod,
    i.confidenceValue = toFloat(row.confidenceValue), i.pubmedId = row.pubmedId,
    i.source = 'IntAct'
RETURN count(i) as INTERACTS_WITH
;


