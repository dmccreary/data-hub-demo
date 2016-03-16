xquery version "1.0-ml";

import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Distinct Element Names in an Ontology'

let $ontology-uri := '/data/smartlogic-models/cycling-taxonomy-v2.rdf'
let $distinct-element-names := s:distinct-element-names($ontology-uri)
let $sorted-element-names :=
  for $element in $distinct-element-names
  order by $element
  return $element

let $content :=
<div class="continer">
   <div class="row">
     <div class="col-md-6">
        URI = {$ontology-uri}<br/>
        Ontology Name = {s:ontology-name($ontology-uri)}<br/>
        Count = {count($distinct-element-names)}<br/>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Count</th>
                  <th>Element</th>
                  <th>Definition</th>
               </tr>
            </thead>
            <tbody>{
               for $element at $count in $sorted-element-names
               return
               <tr>
                  <th>{$count}</th>
                  <td>{$element}</td>
                  <td>{s:element-definition($element)}</td>
               </tr>
            }</tbody>
        </table>
      </div>
   </div>
</div>

return style:assemble-page($title, $content)