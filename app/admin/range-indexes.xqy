xquery version "1.0-ml";

import module namespace dha="http://marklogic.com/data-hub-demo/admin" at "/modules/admin.xqy";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
import module namespace util="http://marklogic.com/data-hub-demo/util" at "/modules/util.xqy";

let $title := 'List and Create Range Indexes'

let $collation-uri := 'http://marklogic.com/collation/codepoint'

(: in the null namespace for now...
<range-indexs>
   <range-index>
      <description></description>
      <category>book</category>
      <namespace></namespace>
      <localname></localname>
      <omnisearch-suggest>true</omnisearch-suggest>
      <within-book-suggest>false</within-book-suggest>
   </range-index>
:)

let $range-indexes-config-uri := '/data/config/range-indexes-config.xml'
let $range-indexes-doc := doc($range-indexes-config-uri)/range-indexes
let $range-indexes := $range-indexes-doc/range-index
(:
let $total-item-count := count()
Total items = {format-number($total-item-count, '#,###')}
         {style:prev-next-pagination-links($start, $page-length, $total-item-count)}
         
         :)

let $content :=
<div class="content">
   <h4>{$title}</h4>
   <div class="row">
      
      <div class="col-md-12">
         
         <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Category</th>
                  <th>Description</th>
                  <th>Namespace</th>
                  <th>Localname</th>
                  <th>Scalar Type</th>
                  <th>Has Range Index</th>
                  <th>Create</th>
               </tr>
            </thead>
            <tbody>
               {   for $range-index in $range-indexes
                     let $category := $range-index/category/text()
                     let $namespace := $range-index/namespace/text()
                     let $localname := $range-index/localname/text()
                     let $scalar-type :=
                        if ($range-index/sclar-type)
                           then $range-index/sclar-type
                           else 'string'
                     (: let $rangespec :=
                        admin:database-range-element-index("string", $range-index/namespace,
                                "$range-index", $collation-uri, fn:false() )
                     let $has-range-index := admin:
                     :)
                     let $has-range-index := dha:has-range-index($range-index/namespace/text(), $localname, 'string')
                     order by $category, $localname
                     return
                     <tr>
                        <td>{$category}</td>
                        <td>{$range-index/description/text()}</td>
                        <td>{$range-index/namespace/text()}</td>
                        <td>{$localname}</td>
                        <td>{$scalar-type}</td>
                        <td>
                           {util:color-background-for-boolean($has-range-index)}
                           {$has-range-index}
                        </td>
                        <td>
                        <a href="/admin/create-range-index.xqy?namespace={$namespace}&amp;localname={$localname}&amp;scalar-type={$scalar-type}">
                        create
                        </a></td>
                     </tr>
               }
            </tbody>
         </table>
      </div>
   </div>
   Elapsed Time = {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') }
</div>

return style:assemble-page($title, $content)