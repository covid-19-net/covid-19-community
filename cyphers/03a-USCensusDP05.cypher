USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP05Admin2.csv' AS row 
MERGE (d:Demographics{id: 'ACS5-' + row.stateFips + '-' + row.countyFips})
SET d.name = d.id, d.totalPopulation = row.totalPopulation, d.male = row.male, d.female = row.female,
    d.age0_4 = row.age0_4, d.age5_9 = row.age5_9, d.age10_14 = row.age10_14, d.age15_19 = row.age15_19, 
    d.age20_24 = row.age20_24, d.age25_34 = row.age25_34, d.age35_44 = row.age35_44, d.age45_54 = row.age45_54,
    d.age55_59 = row.age55_59, d.age60_64 = row.age60_64, d.age65_74 = row.age65_74, d.age75_84 = row.age75_84,
    d.age85_ = row.age85_,
    d.white = row.white, d.blackOrAfricanAmerican = row.blackOrAfricanAmerican, 
    d.americanIndianAndAlaskaNative = row.americanIndianAndAlaskaNative,
    d.asian = row.asian, d.nativeHawaiianAndOtherPacificIslander = row.nativeHawaiianAndOtherPacificIslander,
    d.otherRace = row.otherRace, d.twoOrMoreRaces = row.twoOrMoreRaces,
    d.hispanicOrLatino = row.hispanicOrLatino, d.notHispanicOrLatino = row.notHispanicOrLatino,
    d.stateFips = row.stateFips, d.countyFips = row.countyFips,
    d.source = row.source, d.aggregationLevel = row.aggregationLevel
RETURN count(d) as Demographics
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
SET d.name = d.id, d.totalPopulation = row.totalPopulation, d.male = row.male, d.female = row.female,
    d.age0_4 = row.age0_4, d.age5_9 = row.age5_9, d.age10_14 = row.age10_14, d.age15_19 = row.age15_19, 
    d.age20_24 = row.age20_24, d.age25_34 = row.age25_34, d.age35_44 = row.age35_44, d.age45_54 = row.age45_54,
    d.age55_59 = row.age55_59, d.age60_64 = row.age60_64, d.age65_74 = row.age65_74, d.age75_84 = row.age75_84,
    d.age85_ = row.age85_,
    d.white = row.white, d.blackOrAfricanAmerican = row.blackOrAfricanAmerican, 
    d.americanIndianAndAlaskaNative = row.americanIndianAndAlaskaNative,
    d.asian = row.asian, d.nativeHawaiianAndOtherPacificIslander = row.nativeHawaiianAndOtherPacificIslander,
    d.otherRace = row.otherRace, d.twoOrMoreRaces = row.twoOrMoreRaces,
    d.hispanicOrLatino = row.hispanicOrLatino, d.notHispanicOrLatino = row.notHispanicOrLatino,
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
