xquery version "1.0-ml";
import module namespace search = "http://marklogic.com/appservices/search"
    at "/MarkLogic/appservices/search/search.xqy";

(: See https://docs.marklogic.com/cts:element-query :)
declare namespace skos-xl="http://www.w3.org/2008/05/skos-xl#";

let $ns := xdmp:get-request-field('ns', 'http://www.w3.org/2008/05/skos-xl#')
let $name := xdmp:get-request-field('name', 'literalForm')
let $q := xdmp:get-request-field('q', 'ab')

let $options :=
<search:options xmlns="http://marklogic.com/appservices/search">
 <default-suggestion-source>
   <range collation="http://marklogic.com/collation/" type="xs:string" facet="true">
      <element ns="{$ns}" name="{$name}"/>
   </range>
 </default-suggestion-source>
</search:options>

let $results := search:suggest($q , $options)

return
<results>
   <elapsed-time>{xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } </elapsed-time>
   {for $result in $results
   return
      <item>{$result}</item>
   }
</results>
