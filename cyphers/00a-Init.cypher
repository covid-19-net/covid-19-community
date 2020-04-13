// delete all nodes and drop indices
MATCH (n) DETACH DELETE n;
DROP INDEX ON:Organism(id)
DROP INDEX ON:Publication(id)
DROP INDEX ON:Publication(accession)
DROP INDEX ON:Genome(id)
DROP INDEX ON:Strain(id)
DROP INDEX ON:Gene(id)
DROP INDEX ON:Protein(id

// create indices
CREATE INDEX ON:Organism(id)
CREATE INDEX ON:Publication(id)
CREATE INDEX ON:Publication(accession)
CREATE INDEX ON:Genome(id)
CREATE INDEX ON:Strain(id)
CREATE INDEX ON:Gene(id)
CREATE INDEX ON:Protein(id)