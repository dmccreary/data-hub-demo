xquery version "1.0-ml";

module namespace u = "http://marklogic.com/data-hub/util";

(:
import module namespace u = "http://marklogic.com/data-hub/util" at "/modules/data-hub-util.xqy";
:)

declare function u:remove-empty-elements($element as element()) as element()? {
if ($element/* or $element/text())
  then 
   element {node-name($element)}
      {$element/@*,
          for $child in $element/node()
              return
               if ($child instance of element())
                 then u:remove-empty-elements($child)
                 else $child
      }
    else ()
};

declare function u:unit-tests-status() as element() {
<table>

{
for $uri in cts:uri-match('/unit-tests/*.xqy')
return
   <tr>
      <td><a href="{$uri}">{$uri}</a></td>
   </tr>

}
</table>
};