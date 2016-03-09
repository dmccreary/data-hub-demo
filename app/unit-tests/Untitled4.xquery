xquery version "1.0-ml";

import module namespace rm="http://marklogic.com/data-hub-demo/reference-data" at "/modules/reference.xqy";

declare namespace r="http://marklogic.com/data-hub-demo/reference-data";

let $doc := /r:reference
return
<test-case>
{$doc}
rm:label('person-gender-code', '1')
</test-case>