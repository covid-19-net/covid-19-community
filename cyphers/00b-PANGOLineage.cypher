LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-PANGOLineage.csv' AS row
MERGE (l:Lineage{id: row.lineage})
SET l.name = row.lineage, l.description = row.description, l.alias = row.alias
RETURN count(l) as Lineage
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-PANGOLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 2
MERGE (l1:Lineage{id: row.l1})
MERGE (l0:Lineage{id: row.l0})
MERGE (l0)-[i:IS_A]->(l1)
RETURN count(i) as IS_A
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-PANGOLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 3
MERGE (l2:Lineage{id: row.l2})
MERGE (l1:Lineage{id: row.l1})
MERGE (l1)-[i:IS_A]->(l2)
RETURN count(i) as IS_A
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-PANGOLineage.csv' AS row
WITH row WHERE toInteger(row.levels) >= 4
MERGE (l3:Lineage{id: row.l3})
MERGE (l2:Lineage{id: row.l2})
MERGE (l2)-[i:IS_A]->(l3)
RETURN count(i) as IS_A
; 
LOAD CSV WITH HEADERS 
FROM 'FILE:///00b-PANGOLineage.csv' AS row
WITH row WHERE row.predecessor IS NOT NULL
MERGE (l4:Lineage{id: row.predecessor})
MERGE (l3:Lineage{id: row.lineage})
MERGE (l4)-[i:IS_A]->(l3)
RETURN count(i) as IS_A
; 
