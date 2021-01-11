LOAD CSV WITH HEADERS 
FROM 'FILE:///NodeMetadata.csv' AS row 
MERGE (n:MetaNode{id: row.name})
SET n.name = row.name, n.shortDescription = row.shortDescription, n.description = row.description, n.example = row.example, n.definitionSource = row.definitionSource, n.dataSources = split(row.dataSources,";")
RETURN count(n) as NodeMetadata
;
// create a metagraph of all nodes and relationships
MATCH (a)-[r]->(b)
WITH DISTINCT labels(a) AS a_labels,type(r) AS rel_type,labels(b) AS b_labels   
UNWIND a_labels as l1   
UNWIND b_labels as l2   
MATCH (a:MetaNode {id:l1})   
MATCH (b:MetaNode {id:l2})   
MERGE (a)-[m:META_RELATIONSHIP {name:rel_type}]->(b)   
RETURN count(m) AS META_RELATIONSHIP
;

