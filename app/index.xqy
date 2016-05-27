xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Data Hub Demo Home'

(:
TBD
<a href="/views/view-transform.xqy">View Transform</a><br/>
:)
let $content :=
<div class="container">
   <h4>Welcome to the Data Hub Demo Home</h4>
   <p>The purpose of this application is to teach the concepts of a MarkLogic data hub project.  
   Data Hub projects includes setps such as loading RDBMS data, transforming to canonical data and creating web services.
   This project has a focus on managing refrence data, semantics data (SKOS-XL), data quality and validating canonical documents.
   Please see Dan McCreary if you have questions.
   </p>
   
   <a href="/views/list-staging.xqy">List Input Staging Documents (one document per row)</a><br/>
   
   <a href="/views/list-canonical-docs.xqy">List Output Canonocal Documents</a><br/>
   
   <h4>Semaphore SKOS-XL Reports</h4>
   <a href="/views/list-ontologies.xqy">List Ontologies</a><br/>
   <a href="/views/ontology-metrics.xqy">Ontology Metrics</a><br/>
   <a href="/forms/ontology-search-form.xqy">Ontology Search Form</a><br/>
   
   <h4>Semaphore SKOS-XL Trainsforms</h4>
   <a href="/transforms/index.xqy">All Transforms</a><br/>
   <a href="/transforms/ontology-rdf-to-triples.xqy">Convert to Triples</a><br/>
   
   <h4>Standard Reports</h4>
   <a href="/views/index.xqy">Standard Views</a><br/>
   <a href="/xray/index.xqy">XRay Unit Tests</a><br/>
   <a href="/unit-tests/index.xqy">Individual Unit Tests</a><br/>
   
   <h4>Admin Tools</h4>
   <a href="/admin/index.xqy">Admin Tools</a><br/>
</div>

return style:assemble-page($title, $content)