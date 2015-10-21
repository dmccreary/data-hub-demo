xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
declare namespace prop="http://marklogic.com/xdmp/property";
declare namespace  cpf="http://marklogic.com/cpf";

let $title := 'Last Modified Files'

(: all cts:uri-match('/views/*.xqy') :)
let $all-uris := cts:uris()

(: the start term to display 
start is part of the standard MarkLogic APIs.  Don't change. 
:)
let $start := xs:positiveInteger(xdmp:get-request-field('start', '1'))

(: the number of terms per page to display 
   pageLenth is part of the standard MarkLogic APIs.  Don't change.  :)
let $page-length := xs:positiveInteger(xdmp:get-request-field('pageLength', '10'))

(:
<prop:properties xmlns:prop="http://marklogic.com/xdmp/property">
  <cpf:processing-status xmlns:cpf="http://marklogic.com/cpf">done</cpf:processing-status>
  <cpf:last-updated xmlns:cpf="http://marklogic.com/cpf">2010-05-24T16:28:11.577608-07:00</cpf:last-updated>
:)

(: this sorts all the URIs according to the last modified first :)
let $sorted-uris :=
  for $uri in $all-uris
     let $properties := xdmp:document-properties($uri)
     order by $properties/prop:properties/prop:last-modified descending
  return
     $uri

let $total-uris := xdmp:estimate(/)

return
let $content :=
<div class="content">
   <h4>{$title}</h4>
      <div class="row">
      <div class="col-md-12">
      Total documents = {format-number($total-uris, '#,###')}
         {style:prev-next-pagination-links($start, $page-length, $total-uris)}
         <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>URI</th>
                  <th>Last Modified</th>
                  <th>Age</th>
                  <th>Readable Age</th>
               </tr>
            </thead>
            <tbody>
                {for $uri in subsequence($sorted-uris, $start, $page-length)
                   let $properties := xdmp:document-properties($uri)
                   let $last-modified := $properties/prop:properties/prop:last-modified
                   let $age := current-dateTime() - $last-modified
                return
                   <tr>   
                        <td>{$uri}</td>
                        <td>{$last-modified}</td>
                        <td>{$age}</td>
                        <td>
                          {days-from-duration($age)} days
                          {hours-from-duration($age)} hours
                          {minutes-from-duration($age)} min
                          {seconds-from-duration($age)} sec
                          </td>
                   </tr>
                }
            </tbody>
         </table>
         </div>
     </div>
     Elapsed Time = {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') }
</div>

return style:assemble-page($title, $content)
  
  