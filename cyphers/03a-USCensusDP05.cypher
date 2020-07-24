USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Admin2.csv' AS row 
MERGE (d:Demographics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
SET d.name = d.id, d.totalPopulation = toInteger(row.totalPopulation), 
    d.male = toInteger(row.male), d.female = toInteger(row.female),
    d.age0_4 = toInteger(row.age0_4), d.age5_9 = toInteger(row.age5_9), d.age10_14 = toInteger(row.age10_14),
    d.age15_19 = toInteger(row.age15_19), d.age20_24 = toInteger(row.age20_24), 
    d.age25_34 = toInteger(row.age25_34), d.age35_44 = toInteger(row.age35_44), 
    d.age45_54 = toInteger(row.age45_54), d.age55_59 = toInteger(row.age55_59), 
    d.age60_64 = toInteger(row.age60_64), d.age65_74 = toInteger(row.age65_74), 
    d.age75_84 = toInteger(row.age75_84), d.age85_ = toInteger(row.age85_),
    d.white = toInteger(row.white), d.blackOrAfricanAmerican = toInteger(row.blackOrAfricanAmericantoInteger), 
    d.americanIndianAndAlaskaNative = toInteger(row.americanIndianAndAlaskaNative), d.asian = toInteger(row.asian), 
    d.nativeHawaiianAndOtherPacificIslander = toInteger(row.nativeHawaiianAndOtherPacificIslander),
    d.otherRace = toInteger(row.otherRace), d.twoOrMoreRaces = toInteger(row.twoOrMoreRaces),
    d.hispanicOrLatino = toInteger(row.hispanicOrLatino), d.notHispanicOrLatino = toInteger(row.notHispanicOrLatino),
    d.stateFips = row.stateFips, d.countyFips = row.countyFips,
    d.source = row.source, d.aggregationLevel = row.aggregationLevel
RETURN count(d) as Demographics
;
// Special case for Puerto Rico: Counties become Admin1 divisions
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Admin2.csv' AS row
WITH row WHERE row.stateFips = '72'
MATCH (a:Admin1{code: row.countyFips, country: 'PR'})
MATCH (d:Demographics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MERGE (a)-[h:HAS_DEMOGRAPHICS]->(d)
RETURN count(h) as HAS_DEMOGRAPHICS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Admin2.csv' AS row
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MATCH (d:Demographics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
MERGE (a)-[h:HAS_DEMOGRAPHICS]->(d)
RETURN count(h) as HAS_DEMOGRAPHICS
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Zip.csv' AS row 
MERGE (d:Demographics{id: 'ACS5-' + row.postalCode})
SET d.name = d.id, d.totalPopulation = toInteger(row.totalPopulation), 
    d.male = toInteger(row.male), d.female = toInteger(row.female),
    d.age0_4 = toInteger(row.age0_4), d.age5_9 = toInteger(row.age5_9), d.age10_14 = toInteger(row.age10_14),
    d.age15_19 = toInteger(row.age15_19), d.age20_24 = toInteger(row.age20_24), 
    d.age25_34 = toInteger(row.age25_34), d.age35_44 = toInteger(row.age35_44), 
    d.age45_54 = toInteger(row.age45_54), d.age55_59 = toInteger(row.age55_59), 
    d.age60_64 = toInteger(row.age60_64), d.age65_74 = toInteger(row.age65_74), 
    d.age75_84 = toInteger(row.age75_84), d.age85_ = toInteger(row.age85_),
    d.white = toInteger(row.white), d.blackOrAfricanAmerican = toInteger(row.blackOrAfricanAmericantoInteger), 
    d.americanIndianAndAlaskaNative = toInteger(row.americanIndianAndAlaskaNative), d.asian = toInteger(row.asian), 
    d.nativeHawaiianAndOtherPacificIslander = toInteger(row.nativeHawaiianAndOtherPacificIslander),
    d.otherRace = toInteger(row.otherRace), d.twoOrMoreRaces = toInteger(row.twoOrMoreRaces),
    d.hispanicOrLatino = toInteger(row.hispanicOrLatino), d.notHispanicOrLatino = toInteger(row.notHispanicOrLatino),
    d.postalCode = row.postalCode,
    d.source = row.source, d.aggregationLevel = row.aggregationLevel
RETURN count(d) as Demographics
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Zip.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.postalCode})
MATCH (d:Demographics{id: 'ACS5-' + row.postalCode})
MERGE (p)-[h:HAS_DEMOGRAPHICS]->(d)
RETURN count(h) as HAS_DEMOGRAPHICS
;
