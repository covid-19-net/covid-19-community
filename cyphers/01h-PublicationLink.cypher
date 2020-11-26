// PubMed Central (PMC) Ids
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Ids.csv' AS row
MERGE (p:Publication{id: row.id})
SET p.name = row.id, p.pmcId = row.pmcId, p.doi = row.doi, 
    p.year = row.year, p.volume = row.volume, p.issue = row.issue, p.page = row.page, 
    p.journal = row.journal
RETURN count(p) as Publication_PMC
;
// Preprint (PPR) Ids
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PPR-Ids.csv' AS row
MERGE (p:Publication{id: row.id})
SET p.name = row.id
RETURN count(p) as Publication_PPR
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01h-PMC-UniProtProtein.csv' AS row
MATCH (p:Publication{pmcId: row.id})
MATCH (n:Protein{accession: row.accession, fullLength: 'True'})
MERGE (p)-[m:MENTIONS]->(n)
RETURN count(m) as Publication_PMC_Protein
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM 'FILE:///01h-PMC-UniProtProtein.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (n:Protein{accession: row.accession, fullLength: 'True'})
MERGE (p)-[m:MENTIONS]->(n)
RETURN count(m) as Publication_PPR_Protein
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-CNCBStrain.csv' AS row
MATCH (p:Publication{pmcId: row.id})
MATCH (s:Strain{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_PMC_Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-CNCBStrain.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (s:Strain{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_PPR_Strain
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Genome.csv' AS row
MATCH (p:Publication{pmcId: row.id})
MATCH (g:Genome{refSeq: row.accession})
MERGE (p)-[m:MENTIONS]->(g)
RETURN count(m) as Publication_PMC_Genome
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-Genome.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (g:Genome{refSeq: row.accession})
MERGE (p)-[m:MENTIONS]->(g)
RETURN count(m) as Publication_PPR_Genome
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-PDBStructure.csv' AS row
MATCH (p:Publication{pmcId: row.id})
MATCH (s:Structure{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_PMC_Structure
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PMC-PDBStructure.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (s:Structure{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_PPR_Structure
;
// Handle PubMed publications (only available for PDB Structures)
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PM-PDBStructure.csv' AS row
MERGE (p:Publication{id: row.id})
ON CREATE SET p.name = row.id
RETURN count(p) as Publication_PM   
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-PM-PDBStructure.csv' AS row
MATCH (p:Publication{id: row.id})
MATCH (s:Structure{id: row.accession})
MERGE (p)-[m:MENTIONS]->(s)
RETURN count(m) as Publication_PM_Structure
;    
                    