LOAD CSV WITH HEADERS 
FROM 'FILE:///Continent.csv' AS row 
MERGE (c:Continent{id: row.id})
SET c.name = row.name
RETURN count(c) as Continent;
