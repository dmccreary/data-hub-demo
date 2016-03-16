xquery version "1.0-ml";

(: Data Hub Admin module :)
module namespace dha="http://marklogic.com/data-hub-demo/admin";
(:
import module namespace dha="http://marklogic.com/data-hub-demo/admin" at "/modules/admin.xqy";
:)
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare namespace db="http://marklogic.com/xdmp/database";

(: see https://docs.marklogic.com/guide/search-dev/encodings_collations :)
declare variable $dha:default-colation := 'http://marklogic.com/collation/';

(: return all West Academic Range Indexes :)
declare variable $dha:westacademic-element-indexes :=
   let $config := admin:get-configuration()
   let $all-element-range-indexes := admin:database-get-range-element-indexes($config, xdmp:database("west-academic") )
   return $all-element-range-indexes[starts-with(db:namespace-uri, 'http://westacademic.com/')];

declare variable $dha:westacademic-element-range-index-count := count($dha:westacademic-element-indexes);


declare variable $dha:config-range-indexs :=
      let $range-indexes-config-uri := '/admin/range-indexes.xml'
      let $range-indexes-doc := doc($range-indexes-config-uri)/range-indexes
      return $range-indexes-doc/range-index;


(: get a specific range index
      <range-element-index xmlns="http://marklogic.com/xdmp/database">
         <scalar-type>dateTime</scalar-type>
         <namespace-uri>http://marklogic.com/xdmp/dls</namespace-uri>
         <localname></localname>
         <collation/>
         <range-value-positions>false</range-value-positions>
         <invalid-values>reject</invalid-values>
      </range-element-index>
:)
declare function dha:range-index($namespace as xs:string, $localname as xs:string, $scalar-type as xs:string) as element()? {
let $config := admin:get-configuration()
let $all-element-range-indexes := admin:database-get-range-element-indexes($config, xdmp:database("west-academic") )
return $all-element-range-indexes[db:namespace-uri=$namespace and db:localname = $localname and db:scalar-type = $scalar-type]
};


(: returns true if an existing range index exists  :)
declare function dha:has-range-index($namespace as xs:string, $localname as xs:string, $scalar-type as xs:string) as xs:boolean {
exists(dha:range-index($namespace, $localname, $scalar-type))
};

