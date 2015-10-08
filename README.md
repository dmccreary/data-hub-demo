This repository is for demonstrating some concepts in a MarkLogic Data Hub architecture.

The general ideal is to provide tools that support three key process in the transformation of normalized
RDBMS data into canonical forms:

1. Agile Data Ingest - quickly load data into staging area using a one document per row pattern
2. Agile Transformation of Data
  1. XQuery Template Transforms - ideal when you know the form and order of the output and you have path expression to the inputs
  2. XQuery Node Filter Transforms - ideal when you have rules that touch every node
  3. XQuery Typeswitch Transforms - for complex rule-based transforms
3. Agile REST Services
  1. Use XQuery annotations and the RXQ framework to drive services
  2. Use URL rewriting to provide a flexible URL format

Examples of unit testing and using XRay and Jenkins to automate the testing of these transformations is also provided.