xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";

let $title := 'View Sub Concepts of Ontology'

(: note that this URI needs to be encoded with encode-for-uri() before it arrives :)
let $uri := xdmp:get-request-field('uri')

let $content :=
<div class="content">
  <span class="field-label">Concept URI: </span> {$uri}<br/>
  <span class="field-label">Concept Name: </span> {s:name($uri)}<br/>
  <h4>Narrower Concepts:</h4>
  {s:narrower-concepts($uri)}
</div>

return style:assemble-page($title, $content)