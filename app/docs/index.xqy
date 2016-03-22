xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Data Hub Documentation'

(:
TBD
<a href="/views/view-transform.xqy">View Transform</a><br/>
:)
let $content :=
<div class="container">
   <h4>Welcome to the Data Hub Demo Home</h4>
   <a href="https://www.w3.org/TR/skos-reference/skos-xl.html">SKOS-XL Vocabulary</a><br/>
   
  
</div>

return style:assemble-page($title, $content)