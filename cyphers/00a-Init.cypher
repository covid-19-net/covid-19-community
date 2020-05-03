// delete all nodes and drop indices
MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({},{});

// create constraints
CREATE CONSTRAINT location_c ON (n:Location) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT continent_c ON (n:Continent) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT country_c ON (n:Contry) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin1_c ON (n:Admin1) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT region_c ON (n:Region) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT division_c ON (n:Division) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin2_c ON (n:Admin2) ASSERT n.id IS UNIQUE;
CREATE INDEX admin2_f FOR (n:Admin2) ON (n.fips, n.stateFips);
CREATE CONSTRAINT city_c ON (n:City) ASSERT n.id IS UNIQUE;
                                   
CREATE CONSTRAINT organism_c ON (n:Organism) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT publication_c ON (n:Publication) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT genome_c ON (n:Genome) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT strain_c ON (n:Strain) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT gene_c ON (n:Gene) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT protein_c ON (n:Protein) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT case_c ON (n:Case) ASSERT n.id IS UNIQUE;
CREATE INDEX case_d FOR (n:Case) ON (n.date);

// list constraints
CALL db.constraints();



