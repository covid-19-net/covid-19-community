# Covid-19-Community

This project is a community effort to build a Neo4j Knowledge Graph (KG) that links heterogenous data about the COVID-19 to help fight this outbreak!

Join "GraphHackers, Let’s Unite to Help Save the World — [Graphs4Good 2020](https://medium.com/neo4j/graphhackers-lets-unite-to-help-save-the-world-graphs4good-2020-fed53562b41f)".

What kind of data can you contribute? Here are some ideas:

![](docs/datatypes.png)

## How can you contribute?

* File an [issue](https://github.com/covid-19-net/covid-19-community/issues/new) to discuss your idea so we can coordinate efforts

* We need your help with [specific issues](https://github.com/covid-19-net/covid-19-community/labels/help%20wanted)
* Suggest publically accessible data sets
* Suggest graph queries to gain new insights from the KG
* Add Jupyter Notebooks with data analyses
* Add data and map visualizations
* Help improve the data model
* Report bugs or issues


## How to use this project?

You can run the Jupyter Notebooks in this repo in your web browser:

[![Binder](https://aws-uswest2-binder.pangeo.io/badge_logo.svg)](https://aws-uswest2-binder.pangeo.io/v2/gh/pwrose/coronavirus-knowledge-graph/master?urlpath=lab)

Then naviate to the notebooks folder and run the following notebooks:

* 1a-Strains.ipynb (downloads the latest SARS-CoV-2 strain data and creates node and relationship files in the data folder)

* 1b-... (create notebooks that add new node and relationship files)

* 2-CreateKnowledgeGraph (creates a Neo4j Knowledge Graph by batch-uploading the nodes and relationships)

* 3-ExampleQueries (runs [Cypher](https://neo4j.com/developer/cypher-query-language/) queries on the Knowledge Graph)


## A prototype Subgraph that represents relationships for Virus Strains

![](docs/strains.png)







