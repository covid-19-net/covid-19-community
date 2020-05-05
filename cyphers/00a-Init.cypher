// delete all nodes and drop indices
MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({},{});

// create constraints
CREATE CONSTRAINT location ON (n:Location) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unregion ON (n:UNRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unsubregion ON (n:UNSubRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unintermediateregion ON (n:UNIntermediateRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT country ON (n:Contry) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin1 ON (n:Admin1) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT usregion ON (n:USRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT usdivision ON (n:USDivision) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin2 ON (n:Admin2) ASSERT n.id IS UNIQUE;
CREATE INDEX admin2_f FOR (n:Admin2) ON (n.fips, n.stateFips);
CREATE CONSTRAINT city ON (n:City) ASSERT n.id IS UNIQUE;
                                   
CREATE CONSTRAINT organism ON (n:Organism) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT outbreak ON (n:Outbreak) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT publication ON (n:Publication) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT genome ON (n:Genome) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT strain ON (n:Strain) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT gene ON (n:Gene) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT protein ON (n:Protein) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT cases ON (n:Cases) ASSERT n.id IS UNIQUE;
CREATE INDEX cases_d FOR (n:Cases) ON (n.date);

// list constraints
CALL db.constraints();
CALL db.indexes();



