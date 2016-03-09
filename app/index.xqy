import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Data Hub Demo Home'

(:
TBD
<a href="/views/view-transform.xqy">View Transform</a><br/>
:)
let $content :=
<div class="container">
   <h4>Welcome to the Data Hub Demo Home</h4>
   <a href="/views/list-staging.xqy">List Input Staging Documents (one document per row)</a><br/>
   
   <a href="/views/list-canonical-docs.xqy">List Output Canonocal Documents</a><br/>
   
   <h4>Semaphore SKOS-XL Reports</h4>
   <a href="/views/ontology-list-top-concepts.xqy">List Top Concepts</a><br/>
   <a href="/views/ontology-metrics.xqy">Ontology Metrics</a><br/>
   <a href="/forms/ontology-searh-form.xqy">Ontology Search Form</a><br/>
   
   <h4>Semaphore SKOS-XL Trainsforms</h4>
   <a href="/transforms/ontology-rdf-to-triples.xqy">Convert to Triples</a><br/>
   
   <h4>Standard Reports</h4>
   <a href="/views/index.xqy">Standard Views</a><br/>
   <a href="/xray/index.xqy">XRay Unit Tests</a><br/>
   <a href="/unit-tests/index.xqy">Individual Unit Tests</a><br/>
</div>

return style:assemble-page($title, $content)