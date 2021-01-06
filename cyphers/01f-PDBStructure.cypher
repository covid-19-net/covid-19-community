USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MERGE (c:Chain{id: row.pdbChainId})
SET c.name = row.pdbChainId, c.pdbId = row.pdbId, c.chainId = row.chainId,
    c.entityId = row.entityId, c.type = row.type,
    c.description = row.description, 
    c.category = row.category,
    c.accession = row.accession,
    c.sequence = row.sequence,
    c.uniprotStart = apoc.convert.toIntList(split(row.uniprotStart, ';')), 
    c.uniprotEnd = apoc.convert.toIntList(split(row.uniprotEnd, ';')),
    // pdbStart and pdbEnd contain characters (insertion codes), don't convert to integer list
    c.pdbStart = split(row.pdbStart, ';'), c.pdbEnd = split(row.pdbEnd, ';'),
    c.seqresStart = apoc.convert.toIntList(split(row.seqresStart, ';')), 
    c.seqresEnd = apoc.convert.toIntList(split(row.seqresEnd, ';')),
    c.residues = toInteger(row.residues)
RETURN count(c) as Chain
;
// Note, PDB assigns chains to the full-length UniProt protein
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MATCH (p:Protein{accession: row.accession, fullLength: 'True'})
MATCH (c:Chain{id: row.pdbChainId})
MERGE (p)-[h:HAS_TERTIARY_STRUCTURE]->(c)
SET h.coverage = toFloat(c.residues)/toFloat(size(p.sequence))
RETURN count(h) as HAS_TERTIARY_STRUCTURE
;
// Link chains to cleaved proteins if first and last residue is within residue range
MATCH (c:Chain)<-[:HAS_TERTIARY_STRUCTURE]-(p:Protein)-[:CLEAVED_TO]->(pc:Protein)
WHERE head(c.uniprotStart) >= pc.start AND last(c.uniprotEnd) <= pc.end
MERGE (pc)-[h:HAS_TERTIARY_STRUCTURE]->(c)
SET h.coverage = toFloat(c.residues)/toFloat(size(pc.sequence))
RETURN count(h) as HAS_TERTIARY_STRUCTURE
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBStructure.csv" AS row
MERGE (s:Structure{id: row.pdbId})
SET s.name = row.pdbId, s.title = row.title, s.description = row.description,
    s.releaseDate = date(row.releaseDate),
    s.resolution = toFloat(row.resolution), s.rFree = toFloat(row.rFree), 
    s.methods = split(row.methods,";")
RETURN count(s) as Structure
;
USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "FILE:///01f-PDBChain.csv" AS row
MATCH (c:Chain{id: row.pdbChainId})
MATCH (s:Structure{id: row.pdbId})
MERGE (c)-[h:IS_PART_OF_STRUCTURE]->(s)
RETURN count(h) as IS_PART_OF_STRUCTURE    
;
                



