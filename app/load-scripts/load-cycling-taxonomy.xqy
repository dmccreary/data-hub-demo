xquery version "1.0-ml"; 
 
import module namespace sem = "http://marklogic.com/semantics" 
      at "/MarkLogic/semantics.xqy";
 
 (: Use this: https://docs.marklogic.com/sem:rdf-load :)
 
sem:rdf-load('/Users/dmccrear/Documents/Projects/Smartlogic/RDF-Dumps/cycling-taxonomy-v3.rdf', "rdfxml")

(: the script returns a list of URIs that are created that store the RDF triples :)
 