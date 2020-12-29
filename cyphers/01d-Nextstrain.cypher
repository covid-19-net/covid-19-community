USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///01d-Nextstrain.csv' AS row 
WITH row WHERE NOT row.id IS null
MERGE (s:Strain{gisaidId: row.id}) 
SET s.clade = row.clade,
    s.exposureCountry = row.exposureCountry, s.exposureAdmin1 = row.exposureAdmin1
RETURN count(s) as Strain
;
//USING PERIODIC COMMIT
//LOAD CSV WITH HEADERS 
//FROM 'FILE:///01d-Nextstrain.csv' AS row 
//WITH row WHERE NOT row.clade IS null
//MERGE (c:Clade{id: row.clade})
//SET c.name = row.clade
//RETURN count(c) as Clade
//;
//USING PERIODIC COMMIT
//LOAD CSV WITH HEADERS 
//FROM 'FILE:///01d-Nextstrain.csv' AS row 
//WITH row WHERE NOT row.clade IS null
//MATCH (s:Strain{gisaidId: row.id})
//MATCH (c:Clade{id: row.clade})
//MERGE (s)-[h:HAS_CLADE]->(c)
//RETURN count(h) as HAS_CLADE
//;
