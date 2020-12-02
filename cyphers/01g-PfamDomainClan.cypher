USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomainClan.csv" AS row
MERGE (d:ProteinDomain{id: row.accession})
SET d.name = row.name, d.accession = row.accession, d.description = row.description, d.source = 'Pfam'
RETURN count(d) as ProteinDomain
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomainClan.csv" AS row
WITH row WHERE NOT row.clanId IS null
MERGE (f:ProteinFamily{id: row.clanId})
SET f.name = row.clanName, f.accession = row.clanId, f.source = 'Pfam'
RETURN count(f) as ProteinFamily
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomainClan.csv" AS row
MATCH (d:ProteinDomain{id: row.accession})
MATCH (f:ProteinFamily{id: row.clanId})
MERGE (d)-[i:IS_PART_OF_FAMILY]->(f)
RETURN count(i) as IS_PART_OF_FAMILY
;
                



