// delete all nodes
MATCH (n) DETACH DELETE n;

// delete all constraints and indices
CALL db.index.fulltext.drop('locations');
CALL db.index.fulltext.drop('bioentities');
CALL db.index.fulltext.drop('geoids');
CALL apoc.schema.assert({},{}, true);
                                                                                            
// create constraints and indices
CREATE CONSTRAINT location ON (n:Location) ASSERT n.id IS UNIQUE;
CREATE INDEX location_n FOR (n:Location) ON (n.name);
CREATE INDEX location_l FOR (n:Location) ON (n.location);
CREATE CONSTRAINT world ON (n:World) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unregion ON (n:UNRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unsubregion ON (n:UNSubRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unintermediateregion ON (n:UNIntermediateRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT country ON (n:Country) ASSERT n.id IS UNIQUE;
CREATE INDEX country_n FOR (n:Country) ON (n.name);
CREATE INDEX country_g FOR (n:Country) ON (n.geonameId);
CREATE INDEX country_l FOR (n:Country) ON (n.location);
CREATE CONSTRAINT admin1 ON (n:Admin1) ASSERT n.id IS UNIQUE;
CREATE INDEX admin1_n FOR (n:Admin1) ON (n.name);
CREATE INDEX admin1_f FOR (n:Admin1) ON (n.fips);
CREATE INDEX admin1_p FOR (n:Admin1) ON (n.parentId);
CREATE INDEX admin1_g FOR (n:Admin1) ON (n.geonameId);
CREATE INDEX admin1_l FOR (n:Admin1) ON (n.location);
CREATE CONSTRAINT usregion ON (n:USRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT usdivision ON (n:USDivision) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin2 ON (n:Admin2) ASSERT n.id IS UNIQUE;
CREATE INDEX admin2_f FOR (n:Admin2) ON (n.fips);
CREATE INDEX admin2_gi FOR (n:Admin2) ON (n.geoId);
CREATE INDEX admin2_g FOR (n:Admin2) ON (n.geonameId);
CREATE INDEX admin2_n FOR (n:Admin2) ON (n.name);
CREATE INDEX admin2_l FOR (n:Admin2) ON (n.location);
CREATE CONSTRAINT city ON (n:City) ASSERT n.id IS UNIQUE;
CREATE INDEX city_n FOR (n:City) ON (n.name);
CREATE INDEX city_l FOR (n:City) ON (n.location);
CREATE INDEX city_g FOR (n:City) ON (n.geonameId);
CREATE CONSTRAINT postalcode ON (n:PostalCode) ASSERT n.id IS UNIQUE;
CREATE INDEX postalcode_n FOR (n:PostalCode) ON (n.name);
CREATE INDEX postalcode_p FOR (n:PostalCode) ON (n.placeName);
CREATE INDEX postalcode_l FOR (n:PostalCode) ON (n.location);
CREATE CONSTRAINT tract ON (n:Tract) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT cruiseship ON (n:CruiseShip) ASSERT n.id IS UNIQUE;
                                   
CREATE CONSTRAINT organism ON (n:Organism) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT outbreak ON (n:Outbreak) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT publication ON (n:Publication) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT strain ON (n:Strain) ASSERT n.id IS UNIQUE;
CREATE INDEX strain_n FOR (n:Strain) ON (n.name);
CREATE CONSTRAINT variant ON (n:Variant) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT gene ON (n:Gene) ASSERT n.id IS UNIQUE;
CREATE INDEX gene_a FOR (n:Gene) ON (n.genomeAccession);
CREATE INDEX gene_s FOR (n:Gene) ON (n.start);
CREATE INDEX gene_e FOR (n:Gene) ON (n.end);
CREATE CONSTRAINT protein ON (n:Protein) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT proteinname ON (n:ProteinName) ASSERT n.id IS UNIQUE;
CREATE INDEX proteinname_n FOR (n:ProteinName) ON (n.name);
CREATE INDEX proteinname_a FOR (n:ProteinName) ON (n.accession);
CREATE CONSTRAINT cases ON (n:Cases) ASSERT n.id IS UNIQUE;
CREATE INDEX cases_d FOR (n:Cases) ON (n.date);
CREATE INDEX cases_s FOR (n:Cases) ON (n.source);
                                       
CREATE CONSTRAINT demographics ON (n:Demographics) ASSERT n.id IS UNIQUE;
                                       


// create full text search indices
CALL db.index.fulltext.createNodeIndex('locations',['World', 'UNRegion', 'UNSubRegion', 'UNIntermediateRegion', 'Country', 'Admin1', 'Admin2', 'USRegion', 'USDivision', 'City', 'CruiseShip', 'PostalCode','Tract'],['name', 'placeName', 'iso', 'iso3', 'fips', 'geoId', 'geonameId', 'code']);
CALL db.index.fulltext.createNodeIndex('bioentities',['ProteinName', 'Protein', 'Gene', 'Strain', 'Variant', 'Organism', 'Outbreak'],['name', 'scientificName', 'taxonomyId', 'accession', 'proId', 'genomeAccession', 'geneVariant', 'proteinVariant', 'variantType', 'variantConsequence']);
CALL db.index.fulltext.createNodeIndex('geoids',['UNRegion', 'UNSubRegion', 'UNIntermediateRegion', 'Country', 'Admin1', 'Admin2', 'USRegion', 'USDivision', 'City', 'PostalCode','Tract'],['id','iso', 'iso3', 'fips', 'geoId', 'geonameId','code','name'], {analyzer: 'keyword'});         



// list constraints and indices
CALL db.constraints();
CALL db.indexes();