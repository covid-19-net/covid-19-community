LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MERGE (c:Chain{id: row.pdbChainId})
SET c.name = row.pdbChainId, c.pdbId = row.pdbId, c.chainId = row.chainId, c.accession = row.accession, 
    c.uniprotStart = apoc.convert.toIntList(split(row.uniprotStart, ';')), 
    c.uniprotEnd = apoc.convert.toIntList(split(row.uniprotEnd, ';')),
    // pdbStart and pdbEnd contain characters (insertion codes), don't convert to integer list
    c.pdbStart = split(row.pdbStart, ';'), c.pdbEnd = split(row.pdbEnd, ';'),
    c.seqresStart = apoc.convert.toIntList(split(row.seqresStart, ';')), 
    c.seqresEnd = apoc.convert.toIntList(split(row.seqresEnd, ';'))
RETURN count(c) as Chain
;
// Note, PDB assigns chains to the full-length UniProt protein
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MATCH (p:Protein{accession: row.accession, fullLength: 'True'})
MATCH (c:Chain{id: row.pdbChainId})
MERGE (p)-[h:HAS_TERTIARY_STRUCTURE]->(c)
RETURN count(h) as HAS_TERTIARY_STRUCTURE
;
// Link chains to cleaved proteins if first and last residue is within residue range
MATCH (c:Chain)<-[:HAS_TERTIARY_STRUCTURE]-(p:Protein)-[:CLEAVED_TO]->(pc:Protein)
WHERE head(c.uniprotStart) >= pc.start AND last(c.uniprotEnd) <= pc.end
MERGE (pc)-[h:HAS_TERTIARY_STRUCTURE]->(c)
RETURN count(h) as HAS_TERTIARY_STRUCTURE
;
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructure.csv" AS row
MERGE (s:Structure{id: row.pdbId})
SET s.name = row.pdbId, s.title = row.title, s.description = row.description,
    s.depositDate = date(row.depositDate), s.releaseDate = date(row.releaseDate),
    s.resolution = toFloat(row.resolution), s.rFactor = toFloat(row.rFactor),
    s.rFree = toFloat(row.rFree), s.method = row.method
RETURN count(s) as Structure
;
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MATCH (c:Chain{id: row.pdbChainId})
MATCH (s:Structure{id: row.pdbId})
MERGE (c)-[h:IS_PART_OF_STRUCTURE]->(s)
RETURN count(h) as IS_PART_OF_STRUCTURE    
;
                



