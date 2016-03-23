xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";
declare namespace json="http://marklogic.com/xdmp/json";

let $title := 'List Distinct Predicates'

let $debug := xs:boolean(xdmp:get-request-field('debug', 'false'))

let $sparql-query :=
'SELECT DISTINCT ?p
WHERE {?s ?p ?o}'

(: wtf?
<json:object xmlns:json="http://marklogic.com/xdmp/json"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xs="http://www.w3.org/2001/XMLSchema">
      <json:entry key="p">
         <json:value xsi:type="sem:iri" xmlns:sem="http://marklogic.com/semantics"
            >http://example.com/Cycling-Taxonomy-V2#Born-in</json:value>
      </json:entry>
   </json:object>
   $query-results/json:object/json:entry/json:value/text()
:)

let $query-results := sem:sparql($sparql-query)

let $json-xml-ojbects :=
<root>
  {$query-results}
</root>

return
   if ($debug)
      then $query-results
      else (: continue :)
      
let $predicate-uri-values := $json-xml-ojbects/json:object/json:entry/json:value/text()

let $sorted-uri-values :=
  for $uri in $predicate-uri-values
  order by $uri
  return $uri

let $content :=
<div class="continer">
   <div class="row">
     <div class="col-md-6">
        
        Count = {count($predicate-uri-values)}<br/>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>#</th>
                  <th>URI</th>
               </tr>
            </thead>
            <tbody>{
               for $uri at $count in $sorted-uri-values
               return
               <tr>
                  <th>{$count}</th>
                  <td>{$uri}</td>
                  
               </tr>
            }</tbody>
        </table>
        Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.
      </div>
   </div>
</div>

return style:assemble-page($title, $content)

