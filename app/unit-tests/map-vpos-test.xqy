xquery version "1.0-ml";
declare namespace i="http://example.com/items";
(: test of using a map to store the vertical position as we display items in an SVG rendering :)

(: increment the vertical position :)
declare function local:inc-pos($map as map:map, $inc as xs:decimal) {
map:put($map, 'vpos', map:get($map, 'vpos') + $inc)
};

let $map := map:map()
let $_ := map:put($map, 'vpos', 10.0) (: init our vertical position before we start :)

let $items := 
<items xmlns="http://example.com/items">
   <item>
      <name>red</name>
      <size>50</size>
   </item>
   <item>
      <name>orange</name>
      <size>60</size>
   </item>
   <item>
      <name>yellow</name>
      <size>70</size>
   </item>
   <item>
      <name>green</name>
      <size>90</size>
   </item>
   <item>
      <name>blue</name>
      <size>80</size>
   </item>
   <item>
      <name>indigo</name>
      <size>70</size>
   </item>
   <item>
      <name>violet</name>
      <size>60</size>
   </item>
</items>

return
<svg xmlns="http://www.w3.org/2000/svg">
   <style type="text/css">
     text {{font-family: Arial, Helvetica, sans-serif;}}
     rect {{stroke:blue;stroke-width:2;}}
   </style>
{
   for $item in $items/i:item
      let $this-element-size := $item/i:size/text()
      let $this-color := $item/i:name/text()
      let $current-vpos := map:get($map, 'vpos')
      (:<rect x="10" y="{$current-vpos}" width="150" height="150" style="fill:blue;fill-opacity:0.1;stroke-opacity:0.9">:)
      return
      (<g transform="translate(10, {$current-vpos})">
        <rect x="10" y="0" width="160" height="{$this-element-size}" fill="{$this-color}" style="fill-opacity:0.1;stroke-opacity:0.9"/>
        <text x="15" y="15">{$item/i:name/text()}</text>
        <text x="15" y="30">this height: {$this-element-size}</text>
        <text x="15" y="45">vertical position: {$current-vpos}</text>
      </g>,
      local:inc-pos($map, xs:decimal($this-element-size) + 10)
      )
}
</svg>