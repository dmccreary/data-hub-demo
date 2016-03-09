declare namespace d="http://docbook.org/ns/docbook";

let $titles := cts:search(/d:chapter/d:title, cts:word-query('law') )
return
<results xmlns="http://docbook.org/ns/docbook">
  {for $title in $titles
  let $docbook-uri := xdmp:node-uri($title)
   return
      <div>
          <a href="/view-chapter.xqy?docbook-uri={$docbook-uri}">{$title/text()}</a>
      </div>
   }
</results>