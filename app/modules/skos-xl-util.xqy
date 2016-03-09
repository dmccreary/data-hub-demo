xquery version "1.0-ml";

module namespace s = "http://marklogic.com/skos-xl-util";
(:
import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";
:)
import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";

declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace swa="http://topbraid.org/swa#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace env="http://evn.topbraidlive.org/evnprojects#";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace teamwork="http://topbraid.org/teamwork#";
declare namespace semaphore-core="http://www.smartlogic.com/2014/08/semaphore-core#";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace cycleing="http://example.com/Cycling-Taxonomy-V2#";
declare namespace skos-xl="http://www.w3.org/2008/05/skos-xl#";
declare namespace xsd="http://www.w3.org/2001/XMLSchema#";


(: given an input URI of a SKOS-XL ontology, this will return a sequence the URIS of all core concepts :)
declare function s:concepts($ontology-uri as xs:string) as xs:string* {
let $ontology-doc := doc($ontology-uri)/rdf:RDF
return
   $ontology-doc/rdf:Description[rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"]/@rdf:about/string()
};


declare function s:count-concepts($ontology-uri as xs:string) as xs:nonNegativeInteger {
  count(s:concepts($ontology-uri))
};

(: return a sequence of URIs for the top concepts in a taxonomy
Givent
  <rdf:Description rdf:about="http://example.com/Cycling-Taxonomy-V2#ConceptScheme/Cycling">
    <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#ConceptScheme"/>
    <rdfs:label xml:lang="en">Cycling</rdfs:label>
    <j.4:guid>c61e6d79-060f-4082-8e76-7fc292d4f842</j.4:guid>
    <skos:hasTopConcept rdf:resource="http://example.com/Cycling-Taxonomy-V2#Sporting-Goods-and-Equipment"/>
    <skos:hasTopConcept rdf:resource="http://example.com/Cycling-Taxonomy-V2#Bicycle-Parts-and-Accessories"/>
    <skos:hasTopConcept rdf:resource="http://example.com/Cycling-Taxonomy-V2#Sports-and-Recreation-Services"/>
  </rdf:Description>
:)
declare function s:top-concepts($ontology-uri as xs:string) as xs:string* {
let $ontology-doc := doc($ontology-uri)/rdf:RDF
return
$ontology-doc//skos:hasTopConcept/@rdf:resource/string()
};

(:
<rdf:Description rdf:about="http://example.com/Cycling-Taxonomy-V2#Has-acronym">
    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
    <rdfs:label xml:lang="en">Has-acronym</rdfs:label>
    <rdfs:domain rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
    <rdfs:range rdf:resource="http://www.w3.org/2008/05/skos-xl#Label"/>
    <rdfs:subPropertyOf rdf:resource="http://www.w3.org/2008/05/skos-xl#altLabel"/>
  </rdf:Description>
:)
declare function s:object-properties($ontology-uri as xs:string) as element()* {
let $ontology-doc := doc($ontology-uri)/rdf:RDF
return
   $ontology-doc/rdf:Description[rdf:type/@rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"]
};

(: note that we MUST wrap the output in an elemnet for the results to serialize in oXygen :)
declare function s:rdf-to-ml-triples($ontology-uri as xs:string) as element()* {
let $ontology-root := doc($ontology-uri)/rdf:RDF
return
   <sem:triples xmlns="http://marklogic.com/semantics">
     {sem:rdf-parse($ontology-root, "rdfxml")}
   </sem:triples>
};