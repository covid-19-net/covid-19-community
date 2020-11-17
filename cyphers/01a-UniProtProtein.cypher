USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtProtein.csv' AS row 
MERGE (p:Protein{id: row.id})
// some proteins have the same sequence, but different proIds, use only the first occurance to set properties
ON CREATE SET p.name = row.name, p.synonymes = row.synomymes, p.accession = row.accession, p.proId = row.proId, 
    p.entryName = row.entryName, p.taxonomyId = row.taxonomyId, p.start = toInteger(row.start), 
    p.end = toInteger(row.end), p.fullLength = row.fullLength, p.sequence = row.sequence
RETURN count(p) as Protein
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtProtein.csv' AS row 
MATCH (p:Protein{id: row.id})
WITH p, row
UNWIND split(row.synonymes, ';') AS name
MERGE (n:ProteinName{id: row.id + '-' + row.accession + '-' + row.name})
SET n.name = row.name, n.accession = row.accession
RETURN count(n) as ProteinName
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01a-UniProtProtein.csv' AS row 
MATCH (p:Protein{id: row.id})
MATCH (n:ProteinName{id: row.id + '-' + row.accession + '-' + row.name}) 
MERGE (p)-[m:NAMED_AS]->(n)
RETURN count(m) as NAMED_AS
;
MATCH (p1:Protein)
MATCH (p2:Protein)-[:NAMED_AS]->(n:ProteinName)
WHERE (p1.accession = p2.accession OR p1.accession = n.accession) AND p1.fullLength = 'True' AND p2.fullLength = 'False'
MERGE (p1)-[c:CLEAVED_TO]->(p2)
RETURN count(c) as CLEAVED_TO
;
MATCH (g:Gene)
MATCH (p:Protein)
WHERE g.id = p.id
MERGE (g)-[e:ENCODES]->(p)
RETURN count(e) as ENCODES
;