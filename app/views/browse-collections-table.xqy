xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

(:
This function requires the collection-lexicon database configuration parameter to be enabled. 
Converts a flat list of collections into a hierarchy of collections.
:)
declare function local:get-subcollections($input-collection as xs:string) as element()* {
<collection>
  <name>{$input-collection}</name>
  {
   let $this-level := count( tokenize($input-collection, '/') )
   let $next-level := $this-level + 1
   let $all-collections :=
      xdmp:eval('cts:collections()', (),
         <options xmlns="xdmp:eval">
             <database>{xdmp:database('hrhub-content')}</database>
         </options>
         )
   for $collection in $all-collections
   return
      if (starts-with($collection, $input-collection) and count(tokenize($collection, '/')) = $next-level)
         then
            local:get-subcollections($collection)
         else ()
    }
</collection>
};

(: remove the first collection path from the collection string :)
declare function local:strip-first($collection as xs:string) as xs:string {
  let $tokens := tokenize($collection, '/')
  return
  string-join(
    for $token in subsequence($tokens, 3)
       return
          concat('/', $token)
        , '/')
        
};

let $title := 'Document Counts By Collection'

let $all-collections :=
    xdmp:eval('cts:collections()', (),
         <options xmlns="xdmp:eval">
             <database>{xdmp:database('hrhub-content')}</database>
         </options>
         )

let $root-level-collections :=
distinct-values(
  for $collection in $all-collections
  let $tokens := tokenize($collection, '/')
  return concat('/', $tokens[2])
  )
  
let $all-collections :=
<collections>
   {for $collection in $root-level-collections
    return
       local:get-subcollections($collection)
   }
</collections>

let $html-table :=
<table class="table table-striped table-bordered table-hover table-condensed">
    <thead>
      <tr>
         <th>#</th>
         <th>Type</th>
         <th>Source System</th>
         <th>Source Table</th>
         <th>Document Count</th>
      </tr>
      </thead>
    <tbody>
     {for $collection at $count in $all-collections//collection
         let $token-count := count(tokenize($collection/name, '/'))
         let $col-position := $token-count - 1
         let $count-query := concat('xdmp:estimate(collection("', $collection/name, '"))')
         let $collection-count :=
            xdmp:eval($count-query, (),
                <options xmlns="xdmp:eval">
                    <database>{xdmp:database('hrhub-content')}</database>
                </options>
                )
         return
            <tr>
               <td>{$count}</td>
               {if ($col-position = 1)
                   then
                     <td>
                       {$collection/name/text()}
                     </td>
                   else <td/>
               }
               {if ($col-position = 2)
                   then
                      <td>
                        {local:strip-first($collection/name)}
                      </td>
                   else <td/>
               }
               {if ($col-position = 3)
                   then <td>
                         
                          {substring-after(local:strip-first(local:strip-first($collection/name)), '//')}
                         </td>
                   else <td/>
               }
               <td class="number">{format-number($collection-count, '#,###')}</td>
            </tr>
        }
    </tbody>
</table>

let $content := 
     <div class="container-fluid">
        <h4>{$title}</h4>
        Counts include all document types (Source, Atomic and Canonical)<br/>
        Elapsed Time <b>{xdmp:elapsed-time()}</b><br/>
        Database <b>hrhub-content</b>
        {$html-table}
     </div>

return style:assemble-page($title, $content)