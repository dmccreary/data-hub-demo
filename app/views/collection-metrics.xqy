xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
(: General function that displays database information and list collections with counts.
   Note that the collection lexicon MUST be enabled for this to run. 
   To run this report directly in oXygen with Bootstrap formatting you must configure the Output
   tab on the oXygen transform senerio:
   
   1) Save the file to {$cfn}.html - $cfn is the current base file name without the extension
   2) Check the Open the Browser
   3) Uncheck the XML rendering under the query.
   4) Save it to a folder that has path to the ../resources/css/bootstrap.min.css and site.css
   
   Dan McCreary
   January, 2015
   :)

(: General function to add commas for readability for large counts :)
declare function local:add-commas($in as xs:integer) as xs:string {
  format-number($in, '#,###')
};

let $title := 'Collection Metrics'

(: This depends on the collection lexicon being turned on :)
let $collections := cts:collections()

let $host-name := xdmp:host-name(xdmp:host())

let $system-name :=
   if ($host-name = 'waetueaappp008.accuityextranet.ds')
     then 'Smoke'
     else 'unknown'

let $content :=
<div class="content">
      Hostname: <b>{$host-name} ({$system-name})</b><br/>
      Database Name : <b>{xdmp:database-name(xdmp:database())}</b><br/>
      MarkLogic Version: <b>{xdmp:version()}</b><br/>
      Total Documents: <b>{format-number(xdmp:estimate(doc()), '#,###')}</b><br/>
      
      Collection Count: <b>{count($collections)}</b><br/>
      <table class="table table-striped table-bordered table-hover table-condensed">
         <thead>
            <tr>
               <th>#</th>
               <th>Collection</th>
               <th>Document Count</th>
            </tr>
         </thead>
         <tbody>
            {for $collection at $count in $collections
              return
              <tr>
                 <td>{$count}</td>
                 <td>{$collection}</td>
                 <td class="number">{local:add-commas(xdmp:estimate(collection($collection)))}</td>
              </tr>
            }
         </tbody>
  </table>
  Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.

</div>


return style:assemble-page($title, $content)