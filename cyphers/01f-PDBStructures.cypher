LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
MERGE (c:Chain{id: row.pdbChainId})
SET c.name = row.pdbChainId, c.pdbId = row.pdbId, c.chainId = row.chainId, c.accession = row.accession, 
    c.uniprotStart = apoc.convert.toIntList(split(row.uniprotStart, ';')), 
    c.uniprotEnd = apoc.convert.toIntList(split(row.uniprotEnd, ';')),
    // pdbStart and pdbEnd may contain characters (insertion codes), don't convert to integer list
    c.pdbStart = split(row.pdbStart, ';'), c.pdbEnd = split(row.pdbEnd, ';'),
    c.seqresStart = apoc.convert.toIntList(split(row.seqresStart, ';')), 
    c.seqresEnd = apoc.convert.toIntList(split(row.seqresEnd, ';'))
RETURN count(c) as Chain
;
// Note, PDB assigns chains to the full-length UniProt protein
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
MATCH (p:Protein{accession: row.accession, fullLength: 'True'})
MATCH (c:Chain{id: row.pdbChainId})
MERGE (c)-[h:IS_PROTEIN]->(p)
RETURN count(h) as IS_PROTEIN
;
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
MERGE (s:Structure{id: row.pdbId})
SET s.name = row.pdbId
RETURN count(s) as Structure
;
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
MATCH (s:Structure{id: row.pdbId})
MATCH (c:Chain{id: row.pdbChainId})
MERGE (s)-[h:HAS_CHAIN]->(c)
RETURN count(h) as HAS_CHAIN    
;



