LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteractionProtein.csv" AS row
MERGE (p:Protein{id: row.id})
SET p.name = row.name, p.accession = row.accession, p.pro_id = row.pro_id, 
    p.sequence = row.sequence, p.start = row.start, p.end = row.end, p.fullLength = row.fullLength, 
    p.taxonomyId = row.taxonomyId
RETURN count(p) as Protein
;
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteractionProtein.csv" AS row
MERGE (p:ProteinName{id: row.id})
SET p.name = row.name, p.accession = row.accession, p.pro_id = row.pro_id
RETURN count(p) as ProteinName
;
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteractionProtein.csv" AS row
MATCH (p:Protein{id: row.id})
MATCH (pn:ProteinName{id: row.id})
MERGE (p)-[n:NAMED]->(pn)
RETURN count(n) as NAMED
;                     
LOAD CSV WITH HEADERS FROM "FILE:///01e-ProteinProteinInteraction.csv" AS row
MATCH (pa:Protein{id: row.id_a})
MATCH (pb:Protein{id: row.id_b})
MERGE (pa)-[i:INTERACT]->(pb)
RETURN count(i) as INTERACT
;


