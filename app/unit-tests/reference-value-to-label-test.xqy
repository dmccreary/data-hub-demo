import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

import module namespace u = "http://marklogic.com/data-hub/util" at "/modules/data-hub-util.xqy";


let $title := 'Reference Value To Label'

let $data-element-name := 'person-gender-code'
let $value := 'F'


let $expected := 'Female'

let $actual := u:reference-value-to-label($data-element-name, $value)
let $test-result := fn:deep-equal($actual, $expected)

return
<results>
  <title>{$title}</title>
  <positive-test>
       
       <test-pass>{$test-result}</test-pass>
       <data-element-name>{$data-element-name}</data-element-name>
       <value>{$value}</value>
       <expected>{$expected}</expected>
       <actual>{$actual}</actual>
   </positive-test>
   <negative-test>
       <data-element-name>{$data-element-name}</data-element-name>
       <value>X</value>
       
       <error>{u:reference-value-to-label($data-element-name, 'x')}</error>
   </negative-test>
</results>