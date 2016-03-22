xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace util="http://marklogic.com/data-hub-demo/util" at "/modules/util.xqy";

let $title := 'Triple Store Metrics'

let $local-db-name := xdmp:database-name(xdmp:database())
let $database-name := xdmp:get-request-field('database-name', $local-db-name)

let $options :=
<options xmlns="xdmp:eval">
   <database>{xdmp:database($database-name)}</database>
</options>

(: run these on other databases :)
let $triple-value-statistics := xdmp:eval('cts:triple-value-statistics()', (),$options)
let $document-count := xdmp:eval('xdmp:estimate(/)', (),$options)

let $content :=
<div class="container">
  <div class="row">
  <div class="col-md-10">
  Database-name = {$database-name}
  <table class="table table-striped table-bordered table-hover table-condensed">
      <thead>
         <tr>
            <th>Metric</th>
            <th>Value</th>
            <th>Description</th>
            <th>List</th>
         </tr>
      </thead>
      <tbody>
         <tr>
            <td>Number Documents</td>
            <td class="number">{util:fmt-integer($document-count)}</td>
            <td>We typically store 300 triples in a document.</td>
            <td><a href="/views/list-documents.xqy">List Documents</a></td>
         </tr>
         <tr>
            <td>Total Triples</td>
            <td class="number">{util:fmt-integer($triple-value-statistics/@count)}</td>
            <td>This number includes duplicate triples.</td>
            <td><a href="/views/list-triples.xqy">List Triples</a></td>
         </tr>
         <tr>
            <td>Unique Subjects</td>
            <td class="number">{util:fmt-integer($triple-value-statistics/@unique-subjects)}</td>
            <td>Starting points.</td>
            <td><a href="/views/list-subjects.xqy">List Subjects</a></td>
         </tr>
         <tr>
            <td>Unique Predicates</td>
            <td class="number">{util:fmt-integer($triple-value-statistics/@unique-predicates)}</td>
            <td>Link types.</td>
            <td><a href="/views/list-predicates.xqy">List Predicates</a></td>
         </tr>
         <tr>
            <td>Unique Objects</td>
            <td class="number">{util:fmt-integer($triple-value-statistics/@unique-objects)}</td>
            <td>Ending Points</td>
            <td><a href="/views/list-objects.xqy">List Predicates</a></td>
         </tr>
       </tbody>
     </table>
     Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.
       </div>
       
       {$triple-value-statistics}
  </div>
</div>








return style:assemble-page($title, $content)