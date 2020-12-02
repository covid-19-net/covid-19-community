USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01g-PfamDomainUniProt.csv" AS row
MATCH (p:Protein{accession: row.uniprotId})
MATCH (d:ProteinDomain{id: row.accession})
WHERE toInteger(row.start) >= p.start AND 
      toInteger(row.end) <= p.end
MERGE (d)-[i:IS_PART_OF_PROTEIN]->(p)
SET i.start = toInteger(row.start), i.end = toInteger(row.end)
RETURN count(i) as IS_PART_OF_PROTEIN
;
