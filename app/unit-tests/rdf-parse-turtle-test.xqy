xquery version "1.0-ml"; 
 
import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";
      
let $turtle-document := '
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix dc: <http://purl.org/dc/elements/1.1/> .
    @prefix ex: <http://example.org/people/1.0/> .
  <http://www.w3.org/TR/rdf-syntax-grammar>
    dc:title "RDF/XML Syntax Specification (Revised)" ;
    ex:editor [
      ex:fullname "Dave Beckett";
      ex:homePage <http://purl.org/net/dajobe/>
    ] .'
return sem:rdf-parse($turtle-document, ("turtle", "repair") )