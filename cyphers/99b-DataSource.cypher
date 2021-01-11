LOAD CSV WITH HEADERS 
FROM 'FILE:///DataSource.csv' AS row 
MERGE (d:DataSource{id: row.id})
SET d.id = row.id, d.name = row.name, d.url = row.url, d.license = row.license
RETURN count(d) as DataSource
;
// ETL_FROM: extracted, transformed, loaded from
LOAD CSV WITH HEADERS 
FROM 'FILE:///NodeMetadata.csv' AS row 
UNWIND split(row.dataSources, ';') AS dp
MATCH (d:DataSource{id: dp})
MATCH (n:MetaNode{id: row.name})
MERGE (d)<-[e:ETL_FROM]-(n)
RETURN count(e) as ETL_FROM
;