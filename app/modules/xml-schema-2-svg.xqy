xquery version "1.0-ml";

module namespace xsd2svg="http://danmccreary.com/xsd2svg";
import module namespace svg-util='http://code.google.com/p/xrx/svg-util' at '/modules/svg-util.xqy';
(: import module namespace xsd2svg="http://ttp://danmccreary.com/xsd2svg" at "../modules/xml-schema-2-svg.xqm"; :)

declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare default element namespace "http://www.w3.org/2000/svg";

(: the module is a typeswitch dispatch transform mdoule :)

(: constants :)
declare variable $xsd2svg:element-height := 20.0;
declare variable $xsd2svg:element-spacing := 10.0;
declare variable $xsd2svg:debug := false();

(: This function takes three input parameters:
$input- the root element of an XML Schema as the input
$vpos - the current vertical position on the page - if you call sub-elements you need to pass where they need to start also
$style-uri - the URL to the CSS style sheet
and the initial vertical position on the SVG page and returns the SVG file :)
declare function xsd2svg:main($input as node()*, $map as map:map, $style-uri as xs:string) as node()* {
  for $node in $input
  return
     typeswitch($node)
            case text() return $node
            case element(xs:schema) return xsd2svg:schema($node, $map, $style-uri)
            case element(xs:element) return xsd2svg:element($node, $map, $style-uri)
            case element(xs:sequence) return xsd2svg:sequence($node, $map, $style-uri)
            case element(xs:choice) return xsd2svg:choice($node, $map, $style-uri)
            case element(xs:any) return xsd2svg:any($node, $map, $style-uri)
            case element(xs:simpleType) return xsd2svg:simpleType($node, $map, $style-uri)
            case element(xs:annotation) return xsd2svg:annotation($node, $map, $style-uri)
            case element(xs:complexType) return xsd2svg:complexType($node, $map, $style-uri)
            case element(xs:import) return xsd2svg:import($node, $map, $style-uri)
            (: TODO
            case element(pattern) return xsd2svg:pattern($node)
            :)
            default return <unknown-element>{$node}</unknown-element>
};

(: use this on the node.  It makes sure we don't ever forget to get the child nodes /* :)
declare function xsd2svg:recurse($node as node()*, $map as map:map, $style-uri) as node()* {
  xsd2svg:main($node/*, $map, $style-uri)
};


declare function xsd2svg:schema($node as node(), $map as map:map, $style-uri as xs:string) as node() {
let $css-style := doc($style-uri)
return
<svg xmlns="http://www.w3.org/2000/svg">
    <title>SVG Rendering of XML Schema File = {xdmp:node-uri($node)}</title>
    <style type="text/css">
       {doc($style-uri)}
    </style>
    <text x="10" y="20">XML Schema URI: {xdmp:node-uri($node)}</text>
    {xsd2svg:recurse($node, $map, $style-uri)}
</svg>
};

(: just draw text for now :)
declare function xsd2svg:import($node as node(), $map as map:map, $style-uri as xs:string) as node() {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
return
(
   <g class="import" transform="translate({$hpos}, {$vpos})">
      <text x="10">vpos={$vpos}{' '} Import: {$node/@namespace/string()} {$node/@schemaLocation/string()}</text>
   </g>
   ,xsd2svg:inc-vpos($map, $xsd2svg:element-height)
)
};

(: just draw text for now :)
declare function xsd2svg:annotation($node as node(), $map as map:map, $style-uri as xs:string) as node() {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
return
(
   <g class="annotation" transform="translate(0 {$vpos + $xsd2svg:element-height})">
      <text x="10" y="0" class="annotation-text" fill="gray">vpos={$vpos}{' '}{$node/xs:documentation/text()}</text>
   </g>
   , xsd2svg:inc-vpos($map, $xsd2svg:element-height*2)
)
};

(: this is where we draw each element in a box 
   the x and y are absolute page coordinates
   the name is the name of the element
   and the optional is if the element is required or optonal for the line around the box 
   the cardinality is for the 1 to N relationship
   and the annotation os for the text annotation of the node :)
   
declare function xsd2svg:element($node as node(), $map as map:map, $style-uri as xs:string) as node()* {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
let $name := $node/@name/string()
let $optional :=
   if (xs:integer($node/@minOccurs) = 0)
      then false()
      else true()

let $max-cardinality := $node/@minOccurs/string()
let $annotation := $node/xs:annotation/xs:documentation/text()
return
(
   <g transform="translate({$hpos}, {$vpos})">
       <line x1="0" x2="10" y1="14" y2="14" stroke="black" stroke-width="2"/>
       <rect x="10" y="0" rx="5" ry="5" width="250" height="28" class="xsd-required"/>
       <text x="15" y="20" class="xsd-text">{$name}</text>
       <text x="15" y="45" class="annotation-text" fill="gray">{$max-cardinality}</text>
       <text x="20" y="60" class="annotation-text" fill="gray">{$annotation}</text>
   </g>,
   xsd2svg:inc-vpos($map, $xsd2svg:element-height),
   xsd2svg:main($node/*, $map, $style-uri)
)

};

declare function xsd2svg:complexType($node as node(), $map, $style-uri as xs:string) as node()* {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
return
(
   <g class="complexType" transform="translate({$hpos}, {$vpos})">
      <line class="complexType" x1="{$hpos}" x2="{$hpos + 50}" y1="14" y2="14" stroke="blue" stroke-width="2"/>
   </g>,
   xsd2svg:move-rel($map, 20, 0),
   xsd2svg:recurse($node, $map, $style-uri)
)
};

declare function xsd2svg:simpleType($node, $map, $style-uri as xs:string) as node() {
let $vpos := map:get($map, 'vpos')
let $hpos := map:get($map, 'hpos')
return
(
   <g class="simpleType" transform="translate({$hpos}, {$vpos})">
     <line class="simpleType" x1="10" x2="{$hpos + 100}" y1="14" y2="14" stroke="orange" stroke-width="2"/>,
     {xsd2svg:main($node/*, $map, $style-uri)}
  </g>
  ,xsd2svg:move-rel($map, 20, 0)
)
};

declare function xsd2svg:sequence($node as node(), $map, $style-uri as xs:string) as node() {
let $hpos := map:get($map, 'hpos')
let $vpos := map:get($map, 'vpos')
return
<g class="sequence" transform="translate({$hpos}, {$vpos})">
    <g class="sequence" transform="scale(.5)">
        <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
        <circle fill="black" r="5" cx="15" cy="25"/>
        <circle fill="black" r="5" cx="30" cy="25"/>
        <circle fill="black" r="5" cx="45" cy="25"/>
        <line x1="2" y1="25" x2="58" y2="25" stroke="black"/>
    </g>
    {for $ele at $count in $node/xs:element
     return
    <g transform="translate({$hpos}, {$vpos})">
       {xsd2svg:element($ele, $map, $style-uri)}
    </g>
     }
</g>, xsd2svg:move-rel($map, 20, 0)
};
    
declare function xsd2svg:choice($node as node(), $map, $style-uri as xs:string) as node() {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
return
(
   <g transform="translate({$hpos}, {$vpos})" class="choice">
       <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
       <circle fill="black" r="5" cx="30" cy="12"/>
       <circle fill="black" r="5" cx="30" cy="25"/>
       <circle fill="black" r="5" cx="30" cy="38"/>
       <line x1="2" y1="25" x2="12" y2="25" stroke="black"/>
       <line x1="25" y1="25" x2="58" y2="25" stroke="black"/>
       <line x1="12" y1="25" x2="25" y2="12" stroke="black"/>
       <line x1="25" y1="12" x2="48" y2="12" stroke="black"/>
       <line x1="25" y1="38" x2="48" y2="38" stroke="black"/>
       <line x1="48" y1="12" x2="48" y2="38" stroke="black"/>
   </g>
   ,xsd2svg:move-rel($map, 20, 0)
)
};



declare function xsd2svg:any($node as node(), $map, $style-uri as xs:string) as node() {
let $hpos := xs:decimal(map:get($map, 'hpos'))
let $vpos := xs:decimal(map:get($map, 'vpos'))
return
<g transform="{$hpos}, {$vpos}" class="any">
    <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
    <circle fill="black" r="5" cx="30" cy="12"/>
    <circle fill="black" r="5" cx="30" cy="25"/>
    <circle fill="black" r="5" cx="30" cy="38"/>
    <line x1="2" y1="25" x2="58" y2="25" stroke="black"/>
    <line x1="12" y1="12" x2="48" y2="12" stroke="black"/>
    <line x1="12" y1="38" x2="48" y2="38" stroke="black"/>
    <line x1="12" y1="12" x2="12" y2="38" stroke="black"/>
    <line x1="48" y1="12" x2="48" y2="38" stroke="black"/>
</g>,
xsd2svg:move-rel($map, 20, 0)
};

declare function xsd2svg:skip($node, $map, $style-uri as xs:string) as node()? {
if ($xsd2svg:debug)
  then <skip/>
  else ()
};

(: add the $amount to the vpos key in the $map :)
declare function xsd2svg:move-rel($map as map:map, $x as xs:decimal, $y as xs:decimal) {
map:put($map, 'hpos', xs:decimal(map:get($map, 'vpos')) + $x),
map:put($map, 'vpos', xs:decimal(map:get($map, 'vpos')) + $y)
};

(: add the $amount to the vpos key in the $map :)
declare function xsd2svg:inc-vpos($map as map:map, $amount as xs:decimal) {
map:put($map, 'vpos', xs:decimal(map:get($map, 'vpos') + $amount) )
};