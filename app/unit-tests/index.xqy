import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace util="http://marklogic.com/data-hub-demo/util" at "/modules/util.xqy";

declare namespace prop="http://marklogic.com/xdmp/property";

let $title := 'List Unit Tests'
let $test-status-doc := doc('/unit-tests/test-status.xml')/test-status

let $xquery-uris :=
   for $uri in cts:uri-match('/unit-tests/*.xqy')
   return
     if ($uri = '/unit-tests/index.xqy')
       then ()
       else $uri

let $html-uris := cts:uri-match('/unit-tests/*.html')

let $all-uris := ($xquery-uris, $html-uris)

let $sorted-uris :=
   for $uri in $all-uris
   order by $uri
   return $uri

let $content :=
<div class="container">
   <h4>{$title}</h4>
   <table class="table table-striped table-bordered table-hover table-condensed">
   <thead>
      <tr>
        <th>Test</th>
        <th>Description</th>
        <th>Status</th>
        <th>Last Modified</th>
        <th>Age</th>
      </tr>
   </thead>
    <tbody>
        {
        for $uri in $sorted-uris
         let $this-test := $test-status-doc/test[uri=$uri]
         let $this-test-status := $this-test/status/text()
         let $properties := xdmp:document-properties($uri)
         let $last-modified := $properties/prop:properties/prop:last-modified
         let $age-duration := current-dateTime() - $last-modified
         order by $last-modified descending
         return
            
             <tr>
                <td>
                  <a href="{$uri}">{substring-after($uri, '/unit-tests/')}</a>
                </td>
                <td>
                    {$this-test/description/text()}
                </td>
                <td>
                    {if ($this-test-status = 'pass')
                       then attribute {'class'} {'success'}
                       else attribute {'class'} {'warning'}
                    }
                    {$this-test-status}
                </td>
                <td>
                   {(: '2015-12-09T14:42:18' :)
                   substring(string($last-modified), 1, 16)}
                </td>
                <td>{'' (: substring-before(substring-after(xs:string($age-duration), 'P'), 'S') :)}
                    {util:fmt-duration($age-duration)}
                </td>
             </tr>
        
        }
    </tbody>
</table>
Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.

</div>

return style:assemble-page($title, $content)