xquery version "1.0-ml";

import module namespace s = "http://marklogic.com/skos-xl-util" at "/modules/skos-xl-util.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'List Ontologies'

(: a sequence of uris :)
let $ontologies := s:list-skos-uris()

let $sorted-ontologies :=
  for $uri in $ontologies
  order by s:ontology-name($uri)
  return $uri

let $content :=
<div class="continer">
   <div class="row">
     <div class="col-md-12">
        
        Count = {count($ontologies)}<br/>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Count</th>
                  <th>Name</th>
                  <th>URI</th>
                  <th>Descriptions</th>
                  <th>Concepts</th>
                  <th>View</th>
               </tr>
            </thead>
            <tbody>{
               for $uri at $count in $sorted-ontologies
               return
               <tr>
                  <th>{$count}</th>
                  <td>{s:ontology-name($uri)}</td>
                  <td>{$uri}</td>
                  <td class="number">{format-number(s:count-descriptions($uri), '#,###')}</td>
                  <td class="number">{format-number(s:count-concepts($uri), '#,###')}</td>
                  <td><a href="/views/view-ontology.xqy?uri={$uri}">view</a></td>
               </tr>
            }</tbody>
        </table>
      </div>
   </div>
</div>

return style:assemble-page($title, $content)