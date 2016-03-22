xquery version "1.0-ml";
import module namespace search = "http://marklogic.com/appservices/search" at "/MarkLogic/appservices/search/search.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $q := xdmp:get-request-field('q')
let $ontology-uri := xdmp:get-request-field('uri')
let $debug := xs:boolean(xdmp:get-request-field('debug', 'false'))

return
   if (not($q))
      then
         <error>
            <message>Missing Query Parameter ?q=keywords</message>
         </error> else

let $title := concat('search for ', $q)

let $options := 
<search:options xmlns="http://marklogic.com/appservices/search">
 <default-suggestion-source>
    <range collation="http://marklogic.com/collation/" 
          type="xs:string" facet="true">
      <element ns="" name="hello"/>
   </range>
 </default-suggestion-source>
</search:options>

let $results := search:suggest($q)

let $content :=
<div class="content">
  q = {$q}
  {for $result in $results
    return
      <div>{$result}</div>
  }
</div>

return style:assemble-page($title, $content)