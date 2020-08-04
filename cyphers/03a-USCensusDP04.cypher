USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Admin2.csv' AS row 
MERGE (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.stateFips + '-' + row.countyFips})
SET h.name = 'Housing-' + row.stateFips + '-' + row.countyFips,
    h.medianRoomsInHousingUnits = toFloat(row.medianRoomsInHousingUnits),
    h.ownerOccupiedHousingUnits = toInteger(row.ownerOccupiedHousingUnits),
    h.ownerOccupiedHousingUnitsPct = toFloat(row.ownerOccupiedHousingUnitsPct),
    h.renterOccupiedHousingUnits = toInteger(row.renterOccupiedHousingUnits),
    h.renterOccupiedHousingUnitsPct = toFloat(row.renterOccupiedHousingUnitsPct),
    h.averageHouseholdSizeOfOwnerOccupiedUnit = toFloat(row.averageHouseholdSizeOfOwnerOccupiedUnit),
    h.averageHouseholdSizeOfRenterOccupiedUnit = toFloat(row.averageHouseholdSizeOfRenterOccupiedUnit),
    h.occupiedHousingUnitsWithVehicles = toInteger(row.occupiedHousingUnitsWithVehicles),
    h.occupiedHousingUnitsWithVehiclesPct = toFloat(row.occupiedHousingUnitsWithVehiclesPct),
    h.occupiedHousingUnitsNoVehicles = toInteger(row.occupiedHousingUnitsNoVehicles),
    h.occupiedHousingUnitsNoVehiclesPct = toFloat(row.occupiedHousingUnitsNoVehiclesPct),
    h.`occupantsPerRoom1.00orLess` = toInteger(row.`occupantsPerRoom1.00orLess`),
    h.`occupantsPerRoom1.00orLessPct` = toFloat(row.`occupantsPerRoom1.00orLessPct`),
    h.`occupantsPerRoom1.01to1.50` = toInteger(row.`occupantsPerRoom1.01to1.50`),
    h.`occupantsPerRoom1.01to1.50Pct` = toFloat(row.`occupantsPerRoom1.01to1.50Pct`),
    h.`occupantsPerRoom1.51orMore` = toInteger(row.`occupantsPerRoom1.51orMore`),
    h.`occupantsPerRoom1.51orMorePct` = toFloat(row.`occupantsPerRoom1.51orMorePct`),
    h.stateFips = row.stateFips, h.countyFips = row.countyFips,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as Housing
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Admin2.csv' AS row
MATCH (a:Admin2{fips: row.countyFips, stateFips: row.stateFips})
MATCH (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.stateFips + '-' + row.countyFips})
MERGE (a)-[hh:HAS_HOUSING]->(h)
RETURN count(hh) as HAS_HOUSING
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Zip.csv' AS row 
MERGE (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.postalCode})
SET h.name = 'Housing-' + row.postalCode,
    h.medianRoomsInHousingUnits = toFloat(row.medianRoomsInHousingUnits),
    h.ownerOccupiedHousingUnits = toInteger(row.ownerOccupiedHousingUnits),
    h.ownerOccupiedHousingUnitsPct = toFloat(row.ownerOccupiedHousingUnitsPct),
    h.renterOccupiedHousingUnits = toInteger(row.renterOccupiedHousingUnits),
    h.renterOccupiedHousingUnitsPct = toFloat(row.renterOccupiedHousingUnitsPct),
    h.averageHouseholdSizeOfOwnerOccupiedUnit = toFloat(row.averageHouseholdSizeOfOwnerOccupiedUnit),
    h.averageHouseholdSizeOfRenterOccupiedUnit = toFloat(row.averageHouseholdSizeOfRenterOccupiedUnit),
    h.occupiedHousingUnitsWithVehicles = toInteger(row.occupiedHousingUnitsWithVehicles),
    h.occupiedHousingUnitsWithVehiclesPct = toFloat(row.occupiedHousingUnitsWithVehiclesPct),
    h.occupiedHousingUnitsNoVehicles = toInteger(row.occupiedHousingUnitsNoVehicles),
    h.occupiedHousingUnitsNoVehiclesPct = toFloat(row.occupiedHousingUnitsNoVehiclesPct),
    h.`occupantsPerRoom1.00orLess` = toInteger(row.`occupantsPerRoom1.00orLess`),
    h.`occupantsPerRoom1.00orLessPct` = toFloat(row.`occupantsPerRoom1.00orLessPct`),
    h.`occupantsPerRoom1.01to1.50` = toInteger(row.`occupantsPerRoom1.01to1.50`),
    h.`occupantsPerRoom1.01to1.50Pct` = toFloat(row.`occupantsPerRoom1.01to1.50Pct`),
    h.`occupantsPerRoom1.51orMore` = toInteger(row.`occupantsPerRoom1.51orMore`),
    h.`occupantsPerRoom1.51orMorePct` = toFloat(row.`occupantsPerRoom1.51orMorePct`),
    h.postalCode = row.postalCode,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as Housing
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Zip.csv' AS row
MATCH (p:PostalCode{id: 'zip' + row.postalCode})
MATCH (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.postalCode})
MERGE (p)-[hh:HAS_HOUSING]->(h)
RETURN count(hh) as HAS_HOUSING
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Tract.csv' AS row 
MERGE (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.tract})
SET h.name = 'Housing-' + row.tact,
    h.medianRoomsInHousingUnits = toFloat(row.medianRoomsInHousingUnits),
    h.ownerOccupiedHousingUnits = toInteger(row.ownerOccupiedHousingUnits),
    h.ownerOccupiedHousingUnitsPct = toFloat(row.ownerOccupiedHousingUnitsPct),
    h.renterOccupiedHousingUnits = toInteger(row.renterOccupiedHousingUnits),
    h.renterOccupiedHousingUnitsPct = toFloat(row.renterOccupiedHousingUnitsPct),
    h.averageHouseholdSizeOfOwnerOccupiedUnit = toFloat(row.averageHouseholdSizeOfOwnerOccupiedUnit),
    h.averageHouseholdSizeOfRenterOccupiedUnit = toFloat(row.averageHouseholdSizeOfRenterOccupiedUnit),
    h.occupiedHousingUnitsWithVehicles = toInteger(row.occupiedHousingUnitsWithVehicles),
    h.occupiedHousingUnitsWithVehiclesPct = toFloat(row.occupiedHousingUnitsWithVehiclesPct),
    h.occupiedHousingUnitsNoVehicles = toInteger(row.occupiedHousingUnitsNoVehicles),
    h.occupiedHousingUnitsNoVehiclesPct = toFloat(row.occupiedHousingUnitsNoVehiclesPct),
    h.`occupantsPerRoom1.00orLess` = toInteger(row.`occupantsPerRoom1.00orLess`),
    h.`occupantsPerRoom1.00orLessPct` = toFloat(row.`occupantsPerRoom1.00orLessPct`),
    h.`occupantsPerRoom1.01to1.50` = toInteger(row.`occupantsPerRoom1.01to1.50`),
    h.`occupantsPerRoom1.01to1.50Pct` = toFloat(row.`occupantsPerRoom1.01to1.50Pct`),
    h.`occupantsPerRoom1.51orMore` = toInteger(row.`occupantsPerRoom1.51orMore`),
    h.`occupantsPerRoom1.51orMorePct` = toFloat(row.`occupantsPerRoom1.51orMorePct`),
    h.tract = row.tract,
    h.source = row.source, h.aggregationLevel = row.aggregationLevel
RETURN count(h) as Housing
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-USCensusDP04Tract.csv' AS row
MATCH (t:Tract{id: 'tract' + row.tract})
MATCH (h:Housing{id: 'ACSDP5Y2018.DP04-' + row.tract})
MERGE (t)-[hh:HAS_HOUSING]->(h)
RETURN count(hh) as HAS_HOUSING
;