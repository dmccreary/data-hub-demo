xquery version "1.0-ml";

import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'View Ontology'
let $uri := xdmp:get-request-field('uri')

let $content :=
<div class="content">
  <span class="field-label">Ontology Name: </span> {s:ontology-name($uri)}<br/>
  <span class="field-label">Concept URI: </span> {$uri}<br/>
  <span class="field-label">Default Namespace: </span> {s:ontology-default-namespace($uri)}<br/>

List Literals
   
</div>

return style:assemble-page($title, $content)