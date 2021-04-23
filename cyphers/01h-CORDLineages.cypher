USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-CORDLineages.csv' AS row
MERGE (p:Publication{id: row.id})
SET p.name = row.id, p.pubmedId = row.pubmed_id, p.pmcId = row.pmcid, p.doi = row.doi, 
    p.arxivId = row.arxiv_id, p.year = row.year, p.date = date(row.date), 
    p.journal = row.journal, p.url = row.url, p.abstract = row.abstract, p.title = row.title
RETURN count(p) as Publication_CORDLineage
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-CORDLineages.csv' AS row 
UNWIND split(row.lineages, ';') AS lineage
MERGE (l:Lineage{id: lineage})
SET l.name = lineage
RETURN count(l) as Lineage
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01h-CORDLineages.csv' AS row 
UNWIND split(row.lineages, ';') AS lineage
MATCH (l:Lineage{id: lineage})
MATCH (p:Publication{id: row.id})
MERGE (p)-[m:MENTIONS]->(l)
RETURN count(m) as MENTIONS_Lineage
;