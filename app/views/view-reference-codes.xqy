xquery version "1.0-ml";

import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace r="http://marklogic.com/data-hub-demo/reference" at "/modules/reference.xqy";

let $title := 'View Reference Codes'
let $uri := xdmp:get-request-field('uri')
let $ref-doc := doc($uri)/r:reference

let $sorted-items :=
   for $item in $ref-doc/r:items/r:item
   order by $item/r:value
   return
      $item

let $content :=
<div class="content">
  
  
<div class="row">
     <div class="col-md-12">
        <span class="field-label">Reference Codes URI: </span> {$uri}<br/>
        Count = {format-number(count($sorted-items), '#,###')}<br/>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Count</th>
                  <th>Value</th>
                  <th>Label</th>
                  <th>Definition</th>
                  <th>View</th>
               </tr>
            </thead>
            <tbody>{
               for $item at $count in $sorted-items
               return
               <tr>
                  <th>{$count}</th>
                  <td>{$item/r:value/text()}</td>
                  <td>{$item/r:label/text()}</td>
                  <td>{$item/r:definition/text()}</td>
                  <td><a href="/views/view-reference-codes.xqy?uri={$uri}">view</a></td>
               </tr>
            }</tbody>
        </table>
        Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.
      </div>
   </div>

   
   
</div>

return style:assemble-page($title, $content)