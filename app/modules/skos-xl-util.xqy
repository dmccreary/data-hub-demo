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
(: j.0 is not very semantic.  xmlns:j.0="http://topbraid.org/swa#" :)
declare namespace topbraid-swa="http://topbraid.org/swa#";
declare namespace semaphore-core="http://www.smartlogic.com/2014/08/semaphore-core#";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace cycleing="http://example.com/Cycling-Taxonomy-V2#";
declare namespace skos-xl="http://www.w3.org/2008/05/skos-xl#";
declare namespace xsd="http://www.w3.org/2001/XMLSchema#";

(: Find a list of all the files in MarkLogic with the RDF Root element and at least one SKOS concept :)
declare function s:list-skos-uris() as xs:string* {
(: for systems with over 10,000 ontologies
   replace this with a version of cts:search(/rdf:RDF, cts:attribute-value-query(xs:QName('rdf:resource'), 'http://www.w3.org/2004/02/skos/core#Concept' :)
let $RDF-files := /rdf:RDF
      [rdf:Description/rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"
       or rdf:Description/rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#ConceptScheme"
      ]
for $uri in $RDF-files
return
   xdmp:node-uri($uri)
};

(: given an input URI of a SKOS-XL ontology, this will return a sequence the URIS of all core concepts :)
declare function s:concepts($ontology-uri as xs:string) as xs:string* {
let $ontology-doc := doc($ontology-uri)/rdf:RDF
return
   $ontology-doc/rdf:Description[rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"]/@rdf:about/string()
};

(: given an input URI of a SKOS-XL ontology, this will return a sequence the URIS of all core concepts :)
declare function s:classes($ontology-uri as xs:string) as xs:string* {
let $ontology-doc := doc($ontology-uri)/rdf:RDF
return
   $ontology-doc/rdf:Description[rdf:type/@rdf:resource="http://www.w3.org/2002/07/owl#Class"]/@rdf:about/string()
};


declare function s:count-concepts($ontology-uri as xs:string) as xs:nonNegativeInteger {
  count(s:concepts($ontology-uri))
};

declare function s:count-descriptions($ontology-uri as xs:string) as xs:nonNegativeInteger {
let $ontology := doc($ontology-uri)/rdf:RDF
 return count($ontology/rdf:Description)
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

(: Get the name of the ontology
<rdf:Description rdf:about="urn:x-evn-master:Cycling-Taxonomy-V2">
    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Ontology"/>
    <rdf:type rdf:resource="http://topbraid.org/teamwork#Vocabulary"/>
    <rdf:type rdf:resource="http://evn.topbraidlive.org/evnprojects#Taxonomy"/>
    <owl:imports rdf:resource="http://www.smartlogic.com/2015/02/semaphore-spin-constraints"/>
    <owl:imports rdf:resource="http://www.smartlogic.com/2014/08/semaphore-core"/>
    <j.0:defaultNamespace>http://example.com/Cycling-Taxonomy-V2#</j.0:defaultNamespace>
    <rdfs:label>Cycling Taxonomy V2</rdfs:label>
  </rdf:Description>
  :)
  
(: return the description of the ontology root 
http://www.w3.org/2004/02/skos/core#ConceptScheme
:)
declare function s:ontology-description($ontology-uri as xs:string) as element() {
let $ontology-root := doc($ontology-uri)/rdf:RDF
let $ontology-description := $ontology-root/rdf:Description
   [rdf:type/@rdf:resource="http://www.w3.org/2002/07/owl#Ontology" 
   or rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#ConceptScheme"]
return
  if ($ontology-description)
    then $ontology-description
    else
      <error>
       <message>Error, no rdf:Description of type http://www.w3.org/2002/07/owl#Ontology</message>
      </error>
};

declare function s:ontology-name($ontology-uri as xs:string) as xs:string* {
let $ontology-root := doc($ontology-uri)/rdf:RDF

let $ontology-description := $ontology-root/rdf:Description
   [rdf:type/@rdf:resource="http://www.w3.org/2002/07/owl#Ontology"]
   
let $concept-scheme-description := $ontology-root/rdf:Description
   [rdf:type/@rdf:resource="http://www.w3.org/2004/02/skos/core#ConceptScheme"]
    
let $ontology-description-name := $ontology-description/rdfs:label/text()
let $concept-scheme-name := $concept-scheme-description/rdfs:label/text()
return
   if ($ontology-description-name)
      then $ontology-description-name[1]
      else if ($concept-scheme-name)
         then $concept-scheme-name[1]
         else 'Error, no description label for type http://www.w3.org/2002/07/owl#Ontology or type http://www.w3.org/2004/02/skos/core#ConceptScheme'
};

(: <j.0:defaultNamespace>http://example.com/Cycling-Taxonomy-V2#</j.0:defaultNamespace> :)
declare function s:ontology-default-namespace($ontology-uri as xs:string) as xs:string {
let $ontology-root := doc($ontology-uri)/rdf:RDF
let $ontology-description := $ontology-root/rdf:Description[rdf:type/@rdf:resource="http://www.w3.org/2002/07/owl#Ontology"]
let $default-namespace := $ontology-description/topbraid-swa:defaultNamespace/text()
return
  if ($default-namespace)
    then $default-namespace
    else 'Error, no Description with topbraid-swa:defaultNamespace'
};

(: return a sequence of the distinct elements in an ontology SKOS-XL file :)
declare function s:distinct-element-names($ontology-uri as xs:string)  as xs:string* {
let $ontology-root := doc($ontology-uri)/rdf:RDF
return distinct-values($ontology-root/descendant-or-self::*/name(.))
 };

(: should this be a QName? :)
declare function s:element-definition($element-name as xs:string)  as xs:string* {
'no definition found'
 };
 
 (:
 skos-xl:literalForm
 
   <rdf:Description
    rdf:about="http://example.com/Cycling-Taxonomy-V2#Sporting-Goods-and-Equipment/Sporting-Goods-and-Equipment_en">
    <rdf:type rdf:resource="http://www.w3.org/2008/05/skos-xl#Label"/>
    <skos-xl:literalForm xml:lang="en">Sporting Goods and Equipment</skos-xl:literalForm>
  </rdf:Description>
  
  The Prefix is the ontology URI.  The Suffix is the Concept URI.
  
  Prefix: http://example.com/Cycling-Taxonomy-V2
  Suffix: Sports-and-Recreation-Services
  
  Input:
  http://example.com/Cycling-Taxonomy-V2#Sports-and-Recreation-Services
  
  Full URI:
  http://example.com/Cycling-Taxonomy-V2#Sports-and-Recreation-Services/Sports-and-Recreation-Services_en
 :)
 
 (: 
    Look for the general English Language name of a thing.
    
    this searches ALL ontologies for a literal name given a fully qualified concept or class URI.
    Note it will return the first literal it finds since their might be multiple literalForms.
    Perhaps we should pass in ontology URI and the Concept URI seperatly?
    What if we have two versions of the same ontology? 
    
    <rdf:Description rdf:about="http://proto.smartlogic.com/example#PrivateCompany">
    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Class"/>
    <rdfs:label xml:lang="en">Private Company</rdfs:label>
    <rdfs:subClassOf rdf:resource="http://proto.smartlogic.com/example#Company"/>
  </rdf:Description>
  
  
    <rdf:Description rdf:about="http://proto.smartlogic.com/example#Semaphore">
       <skosxl:prefLabel rdf:resource="http://proto.smartlogic.com/example#Semaphore_"/>
    </rdf:Description>
  
    <rdf:Description rdf:about="http://proto.smartlogic.com/example#Semaphore_">
      <rdf:type rdf:resource="http://www.w3.org/2008/05/skos-xl#Label"/>
      <skosxl:literalForm>Semaphore</skosxl:literalForm>
  </rdf:Description>
  
    :)
 declare function s:name($uri as xs:string) as xs:string* {
 let $suffix := substring-after($uri, '#')
 let $language-code := 'en'
 let $full-uri := concat($uri, '/', $suffix, '_', $language-code)
 let $literal := /rdf:RDF/rdf:Description[@rdf:about=$full-uri]/skos-xl:literalForm/text()
 let $label := /rdf:RDF/rdf:Description[@rdf:about=$uri]/rdfs:label/text()
 let $pref-label-uri := /rdf:RDF/rdf:Description[@rdf:about=$uri]/skos-xl:prefLabel/@rdf:resource[1]
 return
    if ($literal)
       then $literal[1]
       else if ($label)
         then $label[1]
         else if ($pref-label-uri)
         then /rdf:RDF/rdf:Description[@rdf:about=$pref-label-uri]/skos-xl:literalForm/text()[1]
         else concat('no name found for ', $full-uri)
 };
 
 (:
 find all concepts that have this concept-uri as a broader concept 
 <rdf:Description rdf:about="http://example.com/Cycling-Taxonomy-V2#Cycling-Equipment">
    <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
    <skos:broader rdf:resource="http://example.com/Cycling-Taxonomy-V2#Sporting-Goods-and-Equipment"/>
  </rdf:Description>
 
 
                  rdf:type/@rdf:resource='http://www.w3.org/2004/02/skos/core#Concept'
                  and
 :)
 
 declare function s:narrower-concepts($concept-uri as xs:string) {
 /rdf:Description[
                  skos:broader/@rdf:resource=$concept-uri
                 ]
 };