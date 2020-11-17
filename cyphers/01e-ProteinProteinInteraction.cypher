USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE (NOT row.pro_id_a IS NULL) AND (NOT row.pro_id_b IS NULL)
MATCH (pa:Protein{proId: row.pro_id_a})
MATCH (pb:Protein{proId: row.pro_id_b})
MERGE (pa)-[i:INTERACTS_WITH]->(pb)
RETURN count(i) as INTERACTS_WITH
;
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE (NOT row.pro_id_a IS NULL) AND row.pro_id_b IS NULL 
MATCH (pa:Protein{proId: row.pro_id_a})
MATCH (pb:Protein{accession: row.accession_b})
WHERE pb.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH]->(pb)
RETURN count(i) as INTERACTS_WITH
;
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE row.pro_id_a IS NULL AND (NOT row.pro_id_b IS NULL)
MATCH (pa:Protein{accession: row.accession_a})
MATCH (pb:Protein{proId: row.pro_id_b})
WHERE pa.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH]->(pb)
RETURN count(i) as INTERACTS_WITH
;                 
USING PERIODIC COMMIT            
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
WITH row WHERE row.pro_id_a IS NULL AND row.pro_id_b IS NULL
MATCH (pa:Protein{accession: row.accession_a})
MATCH (pb:Protein{accession: row.accession_b})
WHERE pa.fullLength = 'True' AND pb.fullLength = 'True'
MERGE (pa)-[i:INTERACTS_WITH]->(pb)
RETURN count(i) as INTERACTS_WITH
;


