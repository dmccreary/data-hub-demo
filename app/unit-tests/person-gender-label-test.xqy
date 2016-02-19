xquery version "1.0-ml";

import module namespace r="http://marklogic.com/data-hub-demo/reference-data" at "/modules/reference.xqy";


let $doc := /r:reference[r:name='person-gender-code']

return
<test-case>
 
  <label>{r:label('person-gender-code', '1')}</label>
   <doc>{$doc}</doc>
</test-case>