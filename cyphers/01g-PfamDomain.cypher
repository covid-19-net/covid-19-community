USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomain.csv" AS row
MERGE (d:Domain{id: row.accession})
ON CREATE SET d.name = row.name, d.accession = row.accession, d.description = row.description
RETURN count(d) as Domain
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomain.csv" AS row
MATCH (c:Chain{id: row.pdbChainId})
MATCH (d:Domain{id: row.accession})
MERGE (c)-[h:HAS_DOMAIN]->(d)
SET h.start = toInteger(row.start), h.end = toInteger(row.end)
RETURN count(h) as HAS_DOMAIN
;
                



