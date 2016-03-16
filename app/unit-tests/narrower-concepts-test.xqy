xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";

(:
<rdf:Description rdf:about="http://example.com/Cycling-Taxonomy-V2#Cycling-Equipment">
    <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
    <skos:broader rdf:resource="http://example.com/Cycling-Taxonomy-V2#Sporting-Goods-and-Equipment"/>
  </rdf:Description>
  :)

let $concept-uri := 'http://example.com/Cycling-Taxonomy-V2#Sporting-Goods-and-Equipment'

return s:narrower-concepts($concept-uri)

