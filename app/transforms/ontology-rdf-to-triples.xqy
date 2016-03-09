xquery version "1.0-ml";
import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";
import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";

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

let $ontology-uri := xdmp:get-request-field('uri', '/data/smartlogic-models/cycling-taxonomy-v2.rdf')

return
   if (not($ontology-uri))
      then
         <error>
            <message>Missing Query Parameter ?q=keywords</message>
         </error> else

let $triples := s:rdf-to-ml-triples($ontology-uri)
let $triple-count := count($triples/sem:triple)
return
<results>
   <count>{$triple-count}</count>
   {$triples}
</results>