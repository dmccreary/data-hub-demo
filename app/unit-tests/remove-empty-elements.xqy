import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

import module namespace u = "http://marklogic.com/data-hub/util" at "/modules/data-hub-util.xqy";


let $title := 'Remove Empty Elements'

let $input :=
<root xmlns="http://example.com/test">
   <a>A</a>
   <!-- remove these -->
   <b></b>
   <c> </c>
   <d>
      <e>E</e>
      <f>   </f>
   </d>
</root>

let $expected := 
<root xmlns="http://example.com/test">
   <a>A</a>
   <!-- remove these -->
   <d>
      <e>E</e>
   </d>
</root>

let $actual := u:remove-empty-elements($input)
let $test-result := fn:deep-equal($actual, $expected)

return
<results>
   <title>{$title}</title>
   <test-result>{$test-result}</test-result>
   <input>{$input}</input>
   <expected>{$expected}</expected>
   <actual>{$actual}</actual>
</results>