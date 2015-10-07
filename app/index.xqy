import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Data Hub Demo Home'

let $content :=
<div class="container">
   <h4>Welcome to the Data Hub Demo Home</h4>
   <a href="list-input-staging-data.xqy">List Input Staging Data</a><br/>
   <a href="view-transform.xqy">View Transform</a><br/>
   <a href="list-canonical-data.xqy">List Output Canonocal Data</a><br/>
   
   <h4>Standard Reports</h4>
   <a href="xray/index.xqy">XRay Unit Tests</a><br/>
   <a href="unit-tests/index.xqy">Individual Unit Tests</a><br/>
</div>

return style:assemble-page($title, $content)