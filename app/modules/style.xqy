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
      <link rel="stylesheet" href="/ares-modules/resources/css/bootstrap.min.css"/>
      <link rel="stylesheet" href="/ares-modules/resources/css/site.css"/>
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
   <img src="/resources/images/marklogic-logo-small.png"/>
   <a href="/index.xqy">MarkLogic Data Hub Demo</a>
</div>
};

declare function style:footer() as element() {
<div class="footer">
  MarkLogic Data Hub Demo
</div>
};