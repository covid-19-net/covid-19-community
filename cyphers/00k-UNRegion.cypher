MERGE (w:World:Location{id: "m49:1"})
SET w.name = "World"
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row
MERGE (r:UNRegion:Location{id: row.UNRegionCode})
SET r.name = row.UNRegion
RETURN count(r) as UNRegion
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row 
WITH row WHERE NOT row.UNSubRegion IS null
MERGE (s:UNSubRegion:Location{id: row.UNSubRegionCode})
SET s.name = row.UNSubRegion
RETURN count(s) as UNSubRegion
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row
WITH row WHERE NOT row.UNIntermediateRegion IS null
MERGE (n:UNIntermediateRegion:Location{id: row.UNIntermediateRegionCode})
SET n.name = row.UNIntermediateRegion
RETURN count(n) as UNIntermediateRegion
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row 
MATCH (r:UNRegion{id: row.UNRegionCode})
MATCH (w:World{id: "m49:1"})
MERGE (r)-[i:IN]->(w)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row
WITH row WHERE NOT row.UNSubRegion IS null
MATCH (s:UNSubRegion{id: row.UNSubRegionCode})
MATCH (r:UNRegion{id: row.UNRegionCode})
MERGE (s)-[i:IN]->(r)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNAll.csv' AS row 
WITH row WHERE NOT row.UNIntermediateRegion IS null
MATCH (n:UNIntermediateRegion{id: row.UNIntermediateRegionCode})
MATCH (s:UNSubRegion{id: row.UNSubRegionCode})
MERGE (n)-[i:IN]->(s)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNRegion.csv' AS row 
MATCH (c:Country{iso3: row.iso3})
MATCH (r:UNRegion{id: row.UNRegionCode})
MERGE (c)-[i:IN]->(r)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNSubRegion.csv' AS row 
MATCH (c:Country{iso3: row.iso3})
MATCH (s:UNSubRegion{id: row.UNSubRegionCode})
MERGE (c)-[i:IN]->(s)
RETURN count(i) as IN
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00k-UNIntermediateRegion.csv' AS row 
MATCH (c:Country{iso3: row.iso3})
MATCH (n:UNIntermediateRegion{id: row.UNIntermediateRegionCode})
MERGE(c)-[i:IN]->(n)
RETURN count(i) as IN
;
                                        

