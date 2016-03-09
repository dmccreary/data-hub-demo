xquery version "1.0-ml";

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

let $taxonomy-uri := '/data/smartlogic-models/cycling-taxonomy-v2.rdf'

let $doc := doc($taxonomy-uri)
return
<top-concepts>
  <desc>{$taxonomy-uri}</desc>
  {for $top-concept in $doc//skos:hasTopConcept
  return
    <uri>{$top-concept/@rdf:resource/string()}</uri>
  }
</top-concepts>