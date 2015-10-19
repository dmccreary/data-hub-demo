xquery version "1.0-ml";

module namespace style = "http://marklogic.com/data-hub/style";
(:
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";
:)

declare function style:assemble-page($title as xs:string, $content as element()) as element() {

let $set-html-content := xdmp:set-response-content-type("text/html")

(: <a href="views/index.xqy">List Views</a><br/> :)
return
<html>
   <head>
      <title>{$title}</title>
      <link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
      <link rel="stylesheet" href="/resources/css/site.css"/>
   </head>
   <body>
      <div class="container">
         {style:header()}
         {$content}
         {style:footer()}
      </div>
   </body>
</html>
};

declare function style:header() as element() {
<div class="header">
   <a href="/index.xqy"><img src="/resources/images/marklogic-logo-small.png"/></a>
   MarkLogic Data Hub Demo
</div>
};

declare function style:footer() as element() {
<div class="footer">
  MarkLogic Data Hub Demo
</div>
};

(: display the previous to next with page counters between 
call it like this:
   style:prev-next-pagination-links($start, $page-length, $total-count)
:)
declare function style:prev-next-pagination-links(
   $start as xs:positiveInteger, 
   $page-length as xs:positiveInteger, 
   $total-count as xs:positiveInteger) as element() {

(: convert from document number to page numbers :)
let $current-page := round($start div $page-length) + 1
let $last-page := round($total-count div $page-length)

(: used to calculate the page min and maxs :)
let $page-number-min := max( ($current-page - 5, 1) )
let $page-number-max :=
   if ($last-page < 10)
      then $last-page
      else if ($current-page < 5)
        then 10
        else $current-page + 5

return
<div class="prev-next-pagination-links">
    {if ($start >= $page-length)
       then <a href="{xdmp:get-request-path()}?start={$start - $page-length}" class="btn btn-primary">Previous</a>
       else ()
    }
    
    <span class="center-links">

      {for $page in ($page-number-min to $page-number-max)
       return
         if ($page = $current-page)
            then
            <a  class="btn btn-link link-text-black" href="{xdmp:get-request-path()}?start={(($page - 1) * $page-length) + 1}">{$page}</a>
            else
            <a class="btn btn-link" href="{xdmp:get-request-path()}?start={(($page - 1) * $page-length) + 1}">{$page}</a>
       }
     </span>
     
    {if ($start < ($total-count - $page-length))
       then <a href="{xdmp:get-request-path()}?start={$start + $page-length}" class="btn btn-primary">Next</a>
       else ()
    }
</div>
};
