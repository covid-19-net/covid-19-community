#!/bin/bash

DEFAULT_ENDPOINT=bolt://localhost:7687
ENDPOINT=${NEO4J_URI:-$DEFAULT_ENDPOINT}
USERNAME=${NEO4J_USERNAME:-neo4j}
PASSWORD=${NEO4J_PASSWORD:-neo4jbinder}
CYPHERS="../cyphers"
REFDATA="../reference_data"

echo "Endpoint: "$ENDPOINT
echo "Username: "$USERNAME
echo "Password: "$PASSWORD

export cypher_shell="$NEO4J_HOME/bin/cypher-shell"

function run_cypher {
    echo " "
    echo "----------------------------------------------"
    echo "Running $1:"
    echo " "
    cat "$1"
    cat "$1" | "$cypher_shell" -a "$ENDPOINT" -u "$USERNAME" -p "$PASSWORD"
}

# Copy reference files to the Neo4j import directory
cp $REFDATA/Organism.csv "$NEO4J_HOME"/import
cp $REFDATA/Outbreak.csv "$NEO4J_HOME"/import

# Set up the database
run_cypher $CYPHERS/00a-Init.cypher
run_cypher $CYPHERS/00b-Organism.cypher
run_cypher $CYPHERS/00c-Outbreak.cypher
run_cypher $CYPHERS/01a-NCBIStrain.cypher
run_cypher $CYPHERS/01b-Nextstrain.cypher
run_cypher $CYPHERS/01c-NCBIRefSeq.cypher
run_cypher $CYPHERS/01d-PMC-Accession.cypher

