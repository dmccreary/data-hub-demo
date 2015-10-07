This repository is for demonstrating some concepts in a MarkLogic Data Hub architecture.

The general ideal is to provide tools that support three process:

1. Agile Data Ingest - quickly load data into staging area using a one document per row pattern
2. Agile Transformation of Data
## XQuery Template Transforms
## XQuery Node Filter Transforms
## XQuery Typeswitch Transforms
3. Agile REST Services
3.1 Use XQuery annotations and the RXQ framework to drive services
3.2 Use URL rewriting to provide a flexible URL format

Examples of unit testing and using XRay and Jenkins to automate the testing of these transformations is also provided.