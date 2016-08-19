xquery version "1.0-ml";
import module namespace xsd2svg="http://danmccreary.com/xsd2svg" at "/modules/xml-schema-2-svg.xqy";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $uri := xdmp:get-request-field('uri', '')
let $debug := xs:boolean(xdmp:get-request-field('debug', 'false'))
let $style := xdmp:get-request-field('style', '/resources/css/xml-schema-svg-oxygen.css')
(: check for required parameters :)
return
if (not($uri))
    then (
    <error>
        <message>Parameter "uri" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $schema := doc($uri)/xs:schema

let $map := map:map()
let $set-horizontal-position := map:put($map, 'hpos', 11.0)
let $set-vertical-position := map:put($map, 'vpos', 13.0)
let $set-css-uri := map:put($map, 'css-uri', '/resources/css/xml-schema-svg-oxygen.css')

return
if ($debug)
   then
      <debug>
         <uri>{$uri}</uri>
         <style>{$style}</style>
         {$map}
         {$schema}
      </debug>
    else
      let $set-html-content := xdmp:set-response-content-type("image/svg+xml")
      return
      xsd2svg:main($schema, $map, $style)





