xquery version "1.0-ml";
import module namespace search = "http://marklogic.com/appservices/search" at "/MarkLogic/appservices/search/search.xqy";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";
import module namespace style="http://westacademic.com/styles" at "/modules/style.xqy";

declare namespace db="http://marklogic.com/xdmp/database";

let $title := 'Suggest Concept Preferred Label Test'
let $q := xdmp:get-request-field('q', 'law')
let $debug := xs:boolean(xdmp:get-request-field('debug', 'false'))

let $options := 
<search:options xmlns="http://marklogic.com/appservices/search">
   <default-suggestion-source>
     <word>
        <element ns="http://docbook.org/ns/docbook" name="title"/>
     </word>
   </default-suggestion-source>
</search:options>

let $search-results := search:suggest($q, $options)

return
if ($debug)
  then
  <debug>
     <options>{$options}</options>
     <results>
        {for $word in $search-results
          return <word>{$word}</word>}
     </results>
  </debug>
  else
let $content :=
<div class="content">
   <div class="row">
      <div class="col-md-6">
         <form action="{xdmp:get-invoked-path()}">
             <label>Chapter Titles Contain Word:</label>
             <input type="search" name="q" value="{$q}"/>
         </form>
         <ol>
            {for $item in $search-results
             let $clean-term := replace($item, '"', '')
             return
               <li><a href="/search/search-service.xqy?q={$clean-term}">{$clean-term}</a></li>
            }
         </ol>
      </div>
   </div>
   <a href="{xdmp:get-invoked-path()}?q={$q}&amp;debug=true">debug</a><br/>
   Elapsed Time: {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.

</div>

return style:assemble-page($title, $content)