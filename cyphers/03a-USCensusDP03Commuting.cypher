USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingAdmin2.csv' AS row 
MERGE (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
SET c.name = 'Commuting-' + row.stateFips + '-' + row.countyFips,
    c.workers16YearsAndOver = toInteger(row.workers16YearsAndOver),
    c.droveAloneToWorkInCarTruckOrVan = toInteger(row.droveAloneToWorkInCarTruckOrVan),
    c.droveAloneToWorkInCarTruckOrVanPct = toFloat(row.droveAloneToWorkInCarTruckOrVanPct),
    c.carpooledToWorkInCarTruckOrVan = toInteger(row.carpooledToWorkInCarTruckOrVan),
    c.carpooledToWorkInCarTruckOrVanPct = toFloat(row.carpooledToWorkInCarTruckOrVanPct),
    c.publicTransportToWork = toInteger(row.publicTransportToWork),
    c.publicTransportToWorkPct = toFloat(row.publicTransportToWorkPct),
    c.walkedToWork = toInteger(row.walkedToWork),
    c.walkedToWorkPct = toFloat(row.walkedToWorkPct),
    c.otherMeansOfCommutingToWork = toInteger(row.otherMeansOfCommutingToWork),
    c.otherMeansOfCommutingToWorkPct = toFloat(row.otherMeansOfCommutingToWorkPct),
    c.workedAtHome = toInteger(row.workedAtHome),
    c.workedAtHomePct = toFloat(row.workedAtHomePct),
    c.meanTravelTimeToWorkMinutes = toInteger(row.meanTravelTimeToWorkMinutes),
    c.stateFips = row.stateFips, c.countyFips = row.countyFips,
    c.source = row.source, c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Commuting
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingAdmin2.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
MATCH (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.stateFips + '-' + row.countyFips})
MERGE (e)-[h:HAS_COMMUTING]->(c)
RETURN count(h) as HAS_COMMUTING
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingZip.csv' AS row 
MERGE (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
SET c.name = 'Commuting-' + row.postalCode,
    c.workers16YearsAndOver = toInteger(row.workers16YearsAndOver),
    c.droveAloneToWorkInCarTruckOrVan = toInteger(row.droveAloneToWorkInCarTruckOrVan),
    c.droveAloneToWorkInCarTruckOrVanPct = toFloat(row.droveAloneToWorkInCarTruckOrVanPct),
    c.carpooledToWorkInCarTruckOrVan = toInteger(row.carpooledToWorkInCarTruckOrVan),
    c.carpooledToWorkInCarTruckOrVanPct = toFloat(row.carpooledToWorkInCarTruckOrVanPct),
    c.publicTransportToWork = toInteger(row.publicTransportToWork),
    c.publicTransportToWorkPct = toFloat(row.publicTransportToWorkPct),
    c.walkedToWork = toInteger(row.walkedToWork),
    c.walkedToWorkPct = toFloat(row.walkedToWorkPct),
    c.otherMeansOfCommutingToWork = toInteger(row.otherMeansOfCommutingToWork),
    c.otherMeansOfCommutingToWorkPct = toFloat(row.otherMeansOfCommutingToWorkPct),
    c.workedAtHome = toInteger(row.workedAtHome),
    c.workedAtHomePct = toFloat(row.workedAtHomePct),
    c.meanTravelTimeToWorkMinutes = toInteger(row.meanTravelTimeToWorkMinutes),
    c.postalCode = row.postalCode,
    c.source = row.source, c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Commuting
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingZip.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
MATCH (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.postalCode})
MERGE (e)-[h:HAS_COMMUTING]->(c)
RETURN count(h) as HAS_COMMUTING
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingTract.csv' AS row 
MERGE (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.tract})
SET c.name = 'Commuting-' + row.tract,
    c.workers16YearsAndOver = toInteger(row.workers16YearsAndOver),
    c.droveAloneToWorkInCarTruckOrVan = toInteger(row.droveAloneToWorkInCarTruckOrVan),
    c.droveAloneToWorkInCarTruckOrVanPct = toFloat(row.droveAloneToWorkInCarTruckOrVanPct),
    c.carpooledToWorkInCarTruckOrVan = toInteger(row.carpooledToWorkInCarTruckOrVan),
    c.carpooledToWorkInCarTruckOrVanPct = toFloat(row.carpooledToWorkInCarTruckOrVanPct),
    c.publicTransportToWork = toInteger(row.publicTransportToWork),
    c.publicTransportToWorkPct = toFloat(row.publicTransportToWorkPct),
    c.walkedToWork = toInteger(row.walkedToWork),
    c.walkedToWorkPct = toFloat(row.walkedToWorkPct),
    c.otherMeansOfCommutingToWork = toInteger(row.otherMeansOfCommutingToWork),
    c.otherMeansOfCommutingToWorkPct = toFloat(row.otherMeansOfCommutingToWorkPct),
    c.workedAtHome = toInteger(row.workedAtHome),
    c.workedAtHomePct = toFloat(row.workedAtHomePct),
    c.meanTravelTimeToWorkMinutes = toInteger(row.meanTravelTimeToWorkMinutes),
    c.tract = row.tract,
    c.source = row.source, c.aggregationLevel = row.aggregationLevel
RETURN count(c) as Commuting
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP03CommutingTract.csv' AS row
MATCH (e:Economics{id: 'ACSDP5Y2018.DP03-' + row.tract})
MATCH (c:Commuting{id: 'ACSDP5Y2018.DP03-' + row.tract})
MERGE (e)-[h:HAS_COMMUTING]->(c)
RETURN count(h) as HAS_COMMUTING
;