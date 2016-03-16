xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

declare namespace db="http://marklogic.com/xdmp/database";

let $title := 'List Current West Academic Element Range Indexes'
		
let $config := admin:get-configuration()
  return
  (:
  <range-element-index xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns="http://marklogic.com/xdmp/database">
   <scalar-type>dateTime</scalar-type>
   <namespace-uri>http://marklogic.com/xdmp/dls</namespace-uri>
   <localname>created replaced</localname>
   <collation/>
   <range-value-positions>false</range-value-positions>
   <invalid-values>reject</invalid-values>
</range-element-index>
:)

let $all-element-range-indexes := admin:database-get-range-element-indexes($config, xdmp:database("data-hub") )

(: remove the MarkLogic built-in range indexes :)
let $west-range-indexes :=
  for $element in $all-element-range-indexes
      let $namespace-uri := $element/db:namespace-uri
      return 
         if (starts-with($namespace-uri, 'http://marklogic.com'))
              then ()
              else $element

let $element-range-indexes-count := count($west-range-indexes)

let $content :=
<div class="content">
   <h4>{$title}</h4>
      <div class="row">
      <div class="col-md-6">
      Total Range Indexes  = {format-number($element-range-indexes-count, '#,###')}
         
         <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Namespace</th>
                  <th>Name</th>
                  <th>Type</th>
               </tr>
            </thead>
            <tbody>
                {for $elemnt-range-index in $west-range-indexes
                let $namespace-uri := $elemnt-range-index/db:namespace-uri
                let $localname := $elemnt-range-index/db:localname
                 (: order by $namespace-uri, $localname :)
                return    
                   <tr> 
                        <td>{$namespace-uri/text()}</td>
                        <td>{$localname/text()}</td>
                        <td>{$elemnt-range-index/db:scalar-type/text()}</td>
                   </tr>
                }
            </tbody>
         </table>
         </div>
     </div>
     Elapsed Time = {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') }
</div>

return style:assemble-page($title, $content)
       