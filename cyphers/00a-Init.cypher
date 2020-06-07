// delete all nodes
MATCH (n) DETACH DELETE n;

// delete all constraints and indices
CALL apoc.schema.assert({},{});

// create constraints and indices
CREATE CONSTRAINT location ON (n:Location) ASSERT n.id IS UNIQUE;
CREATE INDEX location_n FOR (n:Location) ON (n.name);
CREATE CONSTRAINT world ON (n:World) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unregion ON (n:UNRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unsubregion ON (n:UNSubRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unintermediateregion ON (n:UNIntermediateRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT country ON (n:Country) ASSERT n.id IS UNIQUE;
CREATE INDEX country_n FOR (n:Country) ON (n.name);
CREATE CONSTRAINT admin1 ON (n:Admin1) ASSERT n.id IS UNIQUE;
CREATE INDEX admin1_n FOR (n:Admin1) ON (n.name);
CREATE CONSTRAINT usregion ON (n:USRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT usdivision ON (n:USDivision) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin2 ON (n:Admin2) ASSERT n.id IS UNIQUE;
CREATE INDEX admin2_f FOR (n:Admin2) ON (n.fips, n.stateFips);
CREATE CONSTRAINT city ON (n:City) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT cruiseship ON (n:CruiseShip) ASSERT n.id IS UNIQUE;
                                   
CREATE CONSTRAINT organism ON (n:Organism) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT outbreak ON (n:Outbreak) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT publication ON (n:Publication) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT strain ON (n:Strain) ASSERT n.id IS UNIQUE;
CREATE INDEX strain_n FOR (n:Strain) ON (n.name);
CREATE CONSTRAINT variant ON (n:Variant) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT gene ON (n:Gene) ASSERT n.id IS UNIQUE;
CREATE INDEX gene_s FOR (n:Gene) ON (n.start);
CREATE INDEX gene_e FOR (n:Gene) ON (n.end);
CREATE CONSTRAINT protein ON (n:Protein) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT proteinname ON (n:ProteinName) ASSERT n.id IS UNIQUE;
CREATE INDEX proteinname_n FOR (n:ProteinName) ON (n.name);
CREATE INDEX proteinname_a FOR (n:ProteinName) ON (n.accession);
CREATE CONSTRAINT cases ON (n:Cases) ASSERT n.id IS UNIQUE;
CREATE INDEX cases_d FOR (n:Cases) ON (n.date);

// list constraints and indices
CALL db.constraints();
CALL db.indexes();



