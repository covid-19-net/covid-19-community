LOAD CSV WITH HEADERS FROM "FILE:///01e-virus_data.csv" AS row
CREATE (n:ViralProtein)
SET n = row;

LOAD CSV WITH HEADERS FROM "FILE:///01e-human_data.csv" AS row
CREATE (n:HumanProtein)
SET n = row;

LOAD CSV WITH HEADERS FROM 'FILE:///01e-interactions.csv' AS csvLine
MATCH (v:ViralProtein {SARS_COV2_Protein_ID: csvLine.SARS_COV2_Protein_ID})
MATCH (h:HumanProtein {Human_Protein_ID: csvLine.Human_Protein_ID})
CREATE (v)-[:InteractsWith {INTERACTION_ID: csvLine.Interaction_ID}]->(h)
return v, h;

