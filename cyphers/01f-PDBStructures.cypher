//LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
//MERGE (c:Chain{id: row.pdbChainId})
//SET c.name = row.pdbChainId, c.pdbId = row.pdbId, c.chainId = row.chainId, c.accession = row.accession, 
//    c.uniprotBegin = row.uniprotBegin, c.uniprotEnd = row.uniprotEnd,
//    c.pdbBegin = row.pdbBegin, c.pdbEnd = row.pdbEnd,
//    c.residueBegin = row.residueBegin, c.residueEnd = row.residueEnd
//RETURN count(c) as Chain
//;
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructures.csv" AS row
MERGE (c:Chain{id: row.pdbChainId})
SET c.name = row.pdbChainId, c.pdbId = row.pdbId, c.chainId = row.chainId, c.accession = row.accession, 
    c.uniprotBegin = split(row.uniprotBegin, ';'), c.uniprotEnd = split(row.uniprotEnd, ';'),
    c.pdbBegin = split(row.pdbBegin, ';'), c.pdbEnd = split(row.pdbEnd, ';'),
    c.residueBegin = split(row.residueBegin, ';'), c.residueEnd = split(row.residueEnd, ';')
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



