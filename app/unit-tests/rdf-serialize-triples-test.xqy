xquery version "1.0-ml"; 
 
import module namespace sem = "http://marklogic.com/semantics" 
      at "/MarkLogic/semantics.xqy";

let $triples :=
(
sem:triple(sem:iri("http://example.com/person#dan-mccreary"),
	sem:iri("http://example.com/ns/person#firstName"),
	"Dan"),
sem:triple(sem:iri("http://example.com/person#dan-mccreary"),
	sem:iri("http://example.com/ns/person#lastName"),
	"McCreary")
)

return sem:rdf-serialize($triples, "rdfxml")
