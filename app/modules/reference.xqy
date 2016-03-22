xquery version "1.0-ml";

module namespace r="http://marklogic.com/data-hub-demo/reference";
(:
import module namespace r="http://marklogic.com/data-hub-demo/reference" at "/modules/reference.xqy";
:)
import module namespace json="http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";



declare variable $r:reference-dir := '/data/reference';

(: Given a code name and a reference value, return the label 
Example:
   r:label('person-gender-code', '1') 

will return 'Female'
:)
declare function r:label($reference-code-name as xs:string, $reference-code-value as xs:string) as xs:string {
let $label := /r:reference[r:name=$reference-code-name]/r:items/r:item[r:value=$reference-code-value]/r:label/text()
return
   if ($label)
     then $label
     else concat('No label found for reference code name=', $reference-code-name, ' value=', $reference-code-value)
};

declare function r:uri-code-to-label($reference-code-name as xs:string, $uri-code as xs:string) as xs:string {
let $label := /r:reference[r:name=$reference-code-name]/r:items/r:item[r:uri-code=$uri-code]/r:label/text()
return
   if ($label)
     then $label
     else concat('No label found for reference code name=', $reference-code-name, ' uri-code=', $uri-code)
};

declare function r:uri-code-to-value($reference-code-name as xs:string, $uri-code as xs:string) as xs:string {
let $value := /r:reference[r:name=$reference-code-name]/r:items/r:item[r:uri-code=$uri-code]/r:value/text()
return
   if ($value)
     then $value
     else concat('No value found for reference code name=', $reference-code-name, ' uri-code=', $uri-code)
};

declare function r:value-to-uri-code($reference-code-name as xs:string, $uri-code as xs:string) as xs:string {
let $value := /r:reference[r:name=$reference-code-name]/r:items/r:item[r:value=$uri-code]/r:uri-code/text()
return
   if ($value)
     then $value
     else concat('No value found for reference code name=', $reference-code-name, ' uri-code=', $uri-code)
};

(: returns a single element called items 
Example
   r:items('series-code')

:)
declare function r:items($reference-code-name as xs:string) as element() {
/r:reference[r:name=$reference-code-name]/r:items
};

(: returns a single JSON array of all the item labels for a code 
   like this: :)
declare function r:items-label-json($reference-code-name as xs:string) {
json:array(
  <json:array xmlns:json="http://marklogic.com/xdmp/json"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
     {for $item in r:items($reference-code-name)/r:item
      return
        <json:value xsi:type="xs:string">{$item/r:label/text()}</json:value>
     }
  </json:array>
)
};

declare function r:item-count($reference-code-name as xs:string) as xs:nonNegativeInteger {
   count(/r:reference[r:name=$reference-code-name]/r:items/r:item)
};

declare function r:form-checkboxes($reference-code-name as xs:string) as element()* {
let $items := /r:reference[r:name=$reference-code-name]/r:items/r:item
return
<div class="checkboxes">
   {
   for $item in $items
      let $value := $item/r:value/text()
      return
      <div class="checkbox">
          <label for="{$value}">
            <input type="checkbox" id="{$value}" name="filter-{$reference-code-name}-{$item/r:uri-code/text()}">{$item/r:label/text()}</input><br/>
         </label>
      </div>
   }
   
   <!-- <input type="submit" name="clear" value="Clear"/> -->
</div>
};


declare function r:uri-code-from-label($label as xs:string) as xs:string {
let $lower-case := lower-case($label)
return replace($lower-case, ' ', '-')
};

