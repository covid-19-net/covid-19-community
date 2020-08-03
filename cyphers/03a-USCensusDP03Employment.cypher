USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentAdmin2.csv' AS row 
MERGE (e:Economics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentAdmin2.csv' AS row
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MATCH (e:Economics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MERGE (a)-[h:HAS_ECONOMICS]->(e)
RETURN count(h) as HAS_ECONOMICS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentAdmin2.csv' AS row 
MERGE (e:EmploymentStatus{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
SET e.population16YearsAndOver = toInteger(row.population16YearsAndOver),
    e.population16YearsAndOverInLaborForce = toInteger(row.population16YearsAndOverInLaborForce),
    e.population16YearsAndOverInLaborForcePct = toFloat(row.population16YearsAndOverInLaborForcePct),
    e.population16YearsAndOverInCivilianLaborForce = toInteger(row.population16YearsAndOverInCivilianLaborForce),
    e.population16YearsAndOverInCivilianLaborForcePct = toFloat(row.population16YearsAndOverInCivilianLaborForcePct),
    e.population16YearsAndOverInArmedForces = toInteger(row.population16YearsAndOverInArmedForces),
    e.population16YearsAndOverInArmedForcesPct = toFloat(row.population16YearsAndOverInArmedForcesPct),
    e.population16YearsAndOverNotInLaborForce = toInteger(row.population16YearsAndOverNotInLaborForce),
    e.population16YearsAndOverNotInLaborForcPct = toFloat(row.population16YearsAndOverNotInLaborPct),                     e.stateFips = row.stateFips, e.countyFips = row.countyFips,
    e.source = row.source, e.aggregationLevel = row.aggregationLevel
RETURN count(e) as Employment
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentAdmin2.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MATCH (es:EmploymentStatus{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MERGE (e)-[h:HAS_EMPLOYMENT_STATUS]->(es)
RETURN count(h) as HAS_EMPLOYMENT_STATUS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentZip.csv' AS row 
MERGE (e:EmploymentStatus{id: 'ACS5-' + row.postalCode})
SET e.population16YearsAndOver = toInteger(row.population16YearsAndOver),
    e.population16YearsAndOverInLaborForce = toInteger(row.population16YearsAndOverInLaborForce),
    e.population16YearsAndOverInLaborForcePct = toFloat(row.population16YearsAndOverInLaborForcePct),
    e.population16YearsAndOverInCivilianLaborForce = toInteger(row.population16YearsAndOverInCivilianLaborForce),
    e.population16YearsAndOverInCivilianLaborForcePct = toFloat(row.population16YearsAndOverInCivilianLaborForcePct),
    e.population16YearsAndOverInArmedForces = toInteger(row.population16YearsAndOverInArmedForces),
    e.population16YearsAndOverInArmedForcesPct = toFloat(row.population16YearsAndOverInArmedForcesPct),
    e.population16YearsAndOverNotInLaborForce = toInteger(row.population16YearsAndOverNotInLaborForce),
    e.population16YearsAndOverNotInLaborForcPct = toFloat(row.population16YearsAndOverNotInLaborPct), 
    e.postalCode = row.postalCode,
    e.source = row.source, e.aggregationLevel = row.aggregationLevel
RETURN count(e) as EmploymentStatus
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentZip.csv' AS row
MERGE (e:Economics{id: 'ACS5-' + row.postalCode})
RETURN count(e) as Economics
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentZip.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.postalCode})
MATCH (e:Economics{id: 'ACS5-' + row.postalCode})
MERGE (p)-[h:HAS_ECONOMICS]->(e)
RETURN count(h) as HAS_ECONOMICS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentZip.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.postalCode})
MATCH (es:EmploymentStatus{id: 'ACS5-' + row.postalCode})
MERGE (e)-[h:HAS_EMPLOYMENT_STATUS]->(es)
RETURN count(h) as HAS_EMPLOYMENT_STATUS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentTract.csv' AS row 
MERGE (e:EmploymentStatus{id: 'ACS5-' + row.tract})
SET e.population16YearsAndOver = toInteger(row.population16YearsAndOver),
    e.population16YearsAndOverInLaborForce = toInteger(row.population16YearsAndOverInLaborForce),
    e.population16YearsAndOverInLaborForcePct = toFloat(row.population16YearsAndOverInLaborForcePct),
    e.population16YearsAndOverInCivilianLaborForce = toInteger(row.population16YearsAndOverInCivilianLaborForce),
    e.population16YearsAndOverInCivilianLaborForcePct = toFloat(row.population16YearsAndOverInCivilianLaborForcePct),
    e.population16YearsAndOverInArmedForces = toInteger(row.population16YearsAndOverInArmedForces),
    e.population16YearsAndOverInArmedForcesPct = toFloat(row.population16YearsAndOverInArmedForcesPct),
    e.population16YearsAndOverNotInLaborForce = toInteger(row.population16YearsAndOverNotInLaborForce),
    e.population16YearsAndOverNotInLaborForcPct = toFloat(row.population16YearsAndOverNotInLaborPct), 
    e.tract = row.tract,
    e.source = row.source, e.aggregationLevel = row.aggregationLevel
RETURN count(e) as EmploymentStatus
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentTract.csv' AS row
MERGE (e:Economics{id: 'ACS5-' + row.tract})
RETURN count(e) as Economics
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentTract.csv' AS row
MATCH (t:Tract{id: 'tract' + row.tract})
MATCH (e:Economics{id: 'ACS5-' + row.tract})
MERGE (t)-[h:HAS_ECONOMICS]->(e)
RETURN count(h) as HAS_ECONOMICS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03EmploymentTract.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.tract})
MATCH (es:EmploymentStatus{id: 'ACS5-' + row.tract})
MERGE (e)-[h:HAS_EMPLOYMENT_STATUS]->(es)
RETURN count(h) as HAS_EMPLOYMENT_STATUS
;