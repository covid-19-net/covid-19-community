#!/bin/bash

DEFAULT_ENDPOINT=bolt://localhost:7687
ENDPOINT=${NEO4J_URI:-$DEFAULT_ENDPOINT}
USERNAME=${NEO4J_USERNAME:-neo4j}
PASSWORD=${NEO4J_PASSWORD:-neo4jbinder}
CYPHER=${NEO4J_BIN:-$NEO4J_HOME/bin}
CYPHERS=$COVID19/cyphers
REFDATA=$COVID19/reference_data

echo "Endpoint: "$ENDPOINT
echo "Username: "$USERNAME
echo "Password: "$PASSWORD

export cypher_shell="$CYPHER/cypher-shell"

function run_cypher {
    echo " "
    echo "----------------------------------------------"
    echo "Running $1:"
    echo " "
    cat "$CYPHERS/$1"
    cat "$CYPHERS/$1" | "$cypher_shell" -a "$ENDPOINT" -u "$USERNAME" -p "$PASSWORD"
}

# Copy reference files to the Neo4j import directory
cp $REFDATA/Organism.csv "$NEO4J_IMPORT"
cp $REFDATA/Genome.csv "$NEO4J_IMPORT"
cp $REFDATA/Outbreak.csv "$NEO4J_IMPORT"
cp $REFDATA/NodeMetadata.csv "$NEO4J_IMPORT"
cp $REFDATA/DataSource.csv "$NEO4J_IMPORT"

# Set up the database
if [ "$1" = "-init" ]; then
  run_cypher 00a-Init.cypher
fi

# add Cypher scripts to test here ...
run_cypher 01c-CNCBStrain.cypher
