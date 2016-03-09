xquery version "1.0-ml";

import module namespace style="http://westacademic.com/styles" at "/modules/style.xqy";

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

let $results := search:suggest($q)

let $content :=
<div>
  {for $result in $results
    return
      <div>{$result}</div>
  }
</div>

return style:assemble-page($title, $content)