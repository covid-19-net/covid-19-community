USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomainPDB.csv" AS row
MATCH (c:Chain{id: row.pdbChainId})
MATCH (d:ProteinDomain{id: row.accession})
MERGE (d)-[i:IS_PART_OF_CHAIN]->(c)
SET i.start = toInteger(row.start), i.end = toInteger(row.end)
RETURN count(i) as IS_PART_OF_CHAIN
;
                



