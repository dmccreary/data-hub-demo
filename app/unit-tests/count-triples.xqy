declare namespace sem="http://marklogic.com/semantics";

(:
<sem:triples xmlns:sem="http://marklogic.com/semantics">
  <sem:triple>
    <sem:subject>http://example.com/Cycling-Taxonomy-V2#Outdoor-Recreational-Activities</sem:subject>
    <sem:predicate>http://www.w3.org/1999/02/22-rdf-syntax-ns#type</sem:predicate>
    <sem:object>http://www.w3.org/2004/02/skos/core#Concept</sem:object>
  </sem:triple>
:)

let $triples := //sem:triple

return
<results>
   <count>{count($triples)}</count>
</results>