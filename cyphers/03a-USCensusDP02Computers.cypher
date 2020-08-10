USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersAdmin2.csv' AS row 
MERGE (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.stateFips + '-' + row.countyFips})
SET c.name = 'Computers-' + row.stateFips + '-' + row.countyFips,
    c.totalHouseholds = toInteger(row.totalHouseholds),
    c.withComputer = toInteger(row.withComputer),
    c.withComputerPct = toFloat(row.withComputerPct),
    c.withBroadbandInternet = toInteger(row.withBroadbandInternet),
    c.withBroadbandInternetPct = toFloat(row.withBroadbandInternetPct),           
    c.stateFips = row.stateFips, 
    c.countyFips = row.countyFips,
    c.source = row.source, 
    c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Computers
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersAdmin2.csv' AS row
MATCH (s:SocialCharacteristics{id: 'ACSDP5Y2018.DP02-' + row.stateFips + '-' + row.countyFips})
MATCH (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.stateFips + '-' + row.countyFips})
MERGE (s)-[h:HAS_Computers]->(e)
RETURN count(h) as HAS_Computers
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersZip.csv' AS row 
MERGE (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.postalCode})
SET c.name = 'Computers-' + row.postalCode,
    c.totalHouseholds = toInteger(row.totalHouseholds),
    c.withComputer = toInteger(row.withComputer),
    c.withComputerPct = toFloat(row.withComputerPct),
    c.withBroadbandInternet = toInteger(row.withBroadbandInternet),
    c.withBroadbandInternetPct = toFloat(row.withBroadbandInternetPct),  
    c.postalCode = row.postalCode,
    c.source = row.source, 
    c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Computers
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersZip.csv' AS row
MATCH (s:SocialCharacteristics{id: 'ACSDP5Y2018.DP02-' + row.postalCode})
MATCH (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.postalCode})
MERGE (s)-[h:HAS_Computers]->(e)
RETURN count(h) as HAS_Computers
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersTract.csv' AS row 
MERGE (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.tract})
SET c.name = 'Computers-' + row.tract,
    c.totalHouseholds = toInteger(row.totalHouseholds),
    c.withComputer = toInteger(row.withComputer),
    c.withComputerPct = toFloat(row.withComputerPct),
    c.withBroadbandInternet = toInteger(row.withBroadbandInternet),
    c.withBroadbandInternetPct = toFloat(row.withBroadbandInternetPct),
    c.tract = row.tract,
    c.source = row.source, 
    c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Computers
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP02ComputersTract.csv' AS row
MATCH (s:SocialCharacteristics{id: 'ACSDP5Y2018.DP02-' + row.tract})
MATCH (c:Computers{id: 'ACSDP5Y2018.DP02-' + row.tract})
MERGE (s)-[h:HAS_Computers]->(e)
RETURN count(h) as HAS_Computers
;