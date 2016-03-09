(: $in is a sequence of nodes! :)
declare function local:change-namespace-deep($in as node()*, $new-namespace as xs:string, $prefix as xs:string )  as node()* {
  for $node in $in
  return if ($node instance of element())
         then element
               {QName ($new-namespace,
                          concat($prefix,
                                if ($prefix = '')
                                then '' else ':',
                                local-name($node)))
               }
               {$node/@*, local:change-namespace-deep($node/node(), $new-namespace, $prefix)}
         else
            (: step through document nodes :)
            if ($node instance of document-node())
               then local:change-namespace-deep($node/node(), $new-namespace, $prefix)
               (: for comments and PIs :)
               else $node
 };
 
let $input :=
<a>
  <b>
     <c a1="A1" a2="A2">
       <!-- comment -->
       <d a1="A1" a2="A2">DDD</d>
     </c>
  </b>
  <e>EEE</e>
</a>

return local:change-namespace-deep($input, 'http://example.com', '')