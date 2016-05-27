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

<h4>Top Level Concepts:</h4>
   <ol>
      {for $concept-uri in s:top-concepts($uri)
      return
         <li><a href="/views/view-sub-concepts.xqy?uri={encode-for-uri($concept-uri)}">{s:name($concept-uri)}</a> - {$concept-uri}</li>
      }
   </ol>

<h4>OWL Classes</h4>
   <ol>
      {for $owl-uri in s:classes($uri)
      return
         <li>
            <a href="/views/view-class.xqy?uri={encode-for-uri($owl-uri)}">{s:name($owl-uri)}</a>
            
            - {$owl-uri}</li>
      }
   </ol>
   <h4>Transforms</h4>
   <ol>
      <li><a href="/transforms/store-ontlogy-as-triples.xqy?uri={$uri}">Store Ontology as MarkLogic Triples</a></li>
   </ol>
</div>

return style:assemble-page($title, $content)