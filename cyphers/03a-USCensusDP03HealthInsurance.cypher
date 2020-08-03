USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceAdmin2.csv' AS row 
MERGE (h:HealthInsurance{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
SET h.civilianNoninstitutionalizedPopulation = toInteger(row.civilianNoninstitutionalizedPopulation),
    h.withHealthInsuranceCoverage = toInteger(row.withHealthInsuranceCoverage),
    h.withHealthInsuranceCoveragePct = toFloat(row.withHealthInsuranceCoveragePct),
    h.withPrivateHealthInsurance = toInteger(row.withPrivateHealthInsurance),
    h.withPrivateHealthInsurancePct = toFloat(row.withPrivateHealthInsurancePct),
    h.withPublicCoverage = toInteger(row.withPublicCoverage),
    h.withPublicCoveragePct = toFloat(row.withPublicCoveragePct),
    h.noHealthInsuranceCoverage = toInteger(row.noHealthInsuranceCoverage),
    h.noHealthInsuranceCoveragePct = toFloat(row.noHealthInsuranceCoveragePct),
    h.stateFips = row.stateFips, h.countyFips = row.countyFips,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as HealthInsurance
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceAdmin2.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MATCH (h:HealthInsurance{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MERGE (e)-[hh:HAS_HEALTH_INSURANCE]->(h)
RETURN count(hh) as HAS_HEALTH_INSURANCE
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceZip.csv' AS row 
MERGE (h:HealthInsurance{id: 'ACS5-' + row.postalCode})
SET h.civilianNoninstitutionalizedPopulation = toInteger(row.civilianNoninstitutionalizedPopulation),
    h.withHealthInsuranceCoverage = toInteger(row.withHealthInsuranceCoverage),
    h.withHealthInsuranceCoveragePct = toFloat(row.withHealthInsuranceCoveragePct),
    h.withPrivateHealthInsurance = toInteger(row.withPrivateHealthInsurance),
    h.withPrivateHealthInsurancePct = toFloat(row.withPrivateHealthInsurancePct),
    h.withPublicCoverage = toInteger(row.withPublicCoverage),
    h.withPublicCoveragePct = toFloat(row.withPublicCoveragePct),
    h.noHealthInsuranceCoverage = toInteger(row.noHealthInsuranceCoverage),
    h.noHealthInsuranceCoveragePct = toFloat(row.noHealthInsuranceCoveragePct),
    h.postalCode = row.postalCode,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as HealthInsurance
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceZip.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.postalCode})
MATCH (h:HealthInsurance{id: 'ACS5-' + row.postalCode})
MERGE (e)-[hh:HAS_HEALTH_INSURANCE]->(h)
RETURN count(hh) as HAS_HEALTH_INSURANCE
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceTract.csv' AS row 
MERGE (h:HealthInsurance{id: 'ACS5-' + row.tract})
SET h.civilianNoninstitutionalizedPopulation = toInteger(row.civilianNoninstitutionalizedPopulation),
    h.withHealthInsuranceCoverage = toInteger(row.withHealthInsuranceCoverage),
    h.withHealthInsuranceCoveragePct = toFloat(row.withHealthInsuranceCoveragePct),
    h.withPrivateHealthInsurance = toInteger(row.withPrivateHealthInsurance),
    h.withPrivateHealthInsurancePct = toFloat(row.withPrivateHealthInsurancePct),
    h.withPublicCoverage = toInteger(row.withPublicCoverage),
    h.withPublicCoveragePct = toFloat(row.withPublicCoveragePct),
    h.noHealthInsuranceCoverage = toInteger(row.noHealthInsuranceCoverage),
    h.noHealthInsuranceCoveragePct = toFloat(row.noHealthInsuranceCoveragePct),
    h.tract = row.tract,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as HealthInsurance
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03HealthInsuranceTract.csv' AS row
MATCH (e:Economics{id: 'ACS5-' + row.tract})
MATCH (h:HealthInsurance{id: 'ACS5-' + row.tract})
MERGE (e)-[hh:HAS_HEALTH_INSURANCE]->(i)
RETURN count(hh) as HAS_HEALTH_INSURANCE
;