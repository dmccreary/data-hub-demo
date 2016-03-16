xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace dha="http://marklogic.com/data-hub-demo/admin" at "/modules/admin.xqy";


let $title := 'Create Range Index Service'
let $namespace := xdmp:get-request-field('namespace')
let $localname := xdmp:get-request-field('localname')
let $scalar-type := xdmp:get-request-field('scalar-type')

return
   if (not($namespace) or not($localname) or not($scalar-type))
     then
     <error>
        <message>All three parameters are required, namespace, localname and scalar-type.</message>
     </error>
else

let $database-name := 'west-academic'
let $dbid := xdmp:database($database-name)
let $config := admin:get-configuration() 
let $rangespec := admin:database-range-element-index($scalar-type, $namespace, $localname, $dha:default-colation, fn:false() )
let $spec := admin:database-add-range-element-index($config, $dbid, $rangespec)
let $save := admin:save-configuration($spec)

let $content :=
<div class="content">
   Database Name: {$database-name}<br/>
   Range index created for:<br/>
   Namespace: {$namespace}<br/>
   Localname: {$localname}<br/>
   Scalar Type: {$scalar-type}<br/>
   
   <pre>
     {for $element in $rangespec/*
     return
        <li>{concat(name($element), ': ', $element/text())}</li>
     }
   </pre>
</div>
   
 return style:assemble-page($title, $content)