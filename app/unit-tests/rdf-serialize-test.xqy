xquery version "1.0-ml"; 
 
import module namespace sem = "http://marklogic.com/semantics" 
      at "/MarkLogic/semantics.xqy";
      
sem:rdf-serialize(
    sem:triple(sem:iri("http://example.com/ns/directory#m"),
	sem:iri("http://example.com/ns/person#firstName"),
	"Michelle"), "rdfxml")
