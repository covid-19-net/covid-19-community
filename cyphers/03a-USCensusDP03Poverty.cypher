USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyAdmin2.csv' AS row 
MERGE (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
SET p.name = 'Poverty-' + row.stateFips + '-' + row.countyFips,
    p.povertyAllFamiliesPct = toFloat(row.povertyAllFamiliesPct),
    p.povertyAllPeoplePct = toFloat(row.povertyAllPeoplePct),
    p.stateFips = row.stateFips,
    p.countyFips = row.countyFips,
    p.source = row.source, 
    p.aggregationLevel = row.aggregationLevel
RETURN count(p) as Poverty
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyAdmin2.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
MATCH (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
MERGE (e)-[h:HAS_POVERTY]->(p)
RETURN count(h) as HAS_POVERTY
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyZip.csv' AS row 
MERGE (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
SET p.name = 'Poverty-' + row.postalCode,       
    p.povertyAllFamiliesPct = toFloat(row.povertyAllFamiliesPct),
    p.povertyAllPeoplePct = toFloat(row.povertyAllPeoplePct),
    p.postalCode = row.postalCode,
    p.source = row.source, 
    p.aggregationLevel = row.aggregationLevel
RETURN count(p) as Poverty
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyZip.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
MATCH (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
MERGE (e)-[h:HAS_POVERTY]->(p)
RETURN count(h) as HAS_POVERTY
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyTract.csv' AS row 
MERGE (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.tract})
SET p.name = 'Poverty-' + row.tract,
    p.povertyAllFamiliesPct = toFloat(row.povertyAllFamiliesPct),
    p.povertyAllPeoplePct = toFloat(row.povertyAllPeoplePct),
    p.tract = row.tract,
    p.source = row.source, 
    p.aggregationLevel = row.aggregationLevel
RETURN count(p) as Poverty
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03PovertyTract.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.tract})
MATCH (p:Poverty{id: 'ACSDP5Y2018.DP03-' + row.tract})
MERGE (e)-[h:HAS_POVERTY]->(p)
RETURN count(h) as HAS_POVERTY
;