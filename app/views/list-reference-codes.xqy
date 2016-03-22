xquery version "1.0-ml";

import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace r="http://marklogic.com/data-hub-demo/reference" at "/modules/reference.xqy";

let $title := 'List List Reference Codes'

(: All codes are stored in the reference direcotry :)
let $reference-dir := $r:reference-dir
let $reference-uris := cts:uri-match(concat($reference-dir, '*.xml'))

let $sorted-uris :=
  for $uri in $reference-uris
  order by $uri
  return $uri

let $content :=
<div class="class">
   <div class="row">
     <div class="col-md-12">
        
        Count = {count($reference-uris)}<br/>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Count</th>
                  <th>Name</th>
                  <th>URI</th>
                  <th>Items</th>
                  <th>View</th>
               </tr>
            </thead>
            <tbody>{
               for $uri at $count in $sorted-uris
               let $reference-doc := doc($uri)/r:reference
               return
               <tr>
                  <th>{$count}</th>
                  <td>{$reference-doc/r:name/text()}</td>
                  <td>{$uri}</td>
                  <td class="number">{format-number(count($reference-doc/r:items/r:item), '#,###')}</td>
                  <td><a href="/views/view-reference-codes.xqy?uri={$uri}">view</a></td>
               </tr>
            }</tbody>
        </table>
        Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.
      </div>
   </div>
</div>

return style:assemble-page($title, $content)