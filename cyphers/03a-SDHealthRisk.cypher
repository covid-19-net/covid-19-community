USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-SDHealthRisk.csv' AS row 
MERGE (h:HealthRisk{id: 'SDHealth-' + row.tract})
SET h.highBloodPressurePct = row.highBloodPressurePct, h.cancerPct = row.cancerPct, h.asthmaPct = row.asthmaPct,
    h.heartDiseasePct = row.heartDiseasePct, h.lungDiseaseCOPDPct = row.lungDiseaseCOPDPct, 
    h.diabetesPct = row.diabetesPct, h.highCholesterolPct = row.highCholesterolPct, 
    h.kidneyDiseasePct = row.kidneyDiseasePct, h.mentalHealthPct = row.mentalHealthPct, h.obesityPct = row.obesityPct,
    h.poorPhysicalHealthPct = row.poorPhysicalHealthPc, h.strokePct = row.strokePct
RETURN count(h) as HealthRisk
;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'FILE:///03a-SDHealthRisk.csv' AS row
MATCH (h:HealthRisk{id: 'SDHealth-' + row.tract})
MATCH (t:Tract{id: 'tract' + row.tract})
MERGE (h)-[r:REPORTED_IN]->(t)
RETURN count(r) as REPORTED_IN
;

