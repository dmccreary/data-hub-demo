xquery version "1.0-ml";
import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Administration Tools'

let $view-description-doc := doc('/admin/descriptions.xml')/view-descriptions

let $content :=
<div class="container">
   <h4>{$title}</h4>
   <table class="table table-striped table-bordered table-hover table-condensed">
   <thead>
      <tr>
         <th>URI</th>
         <th>Description</th>
         <!-- <th>Author</th> -->
      </tr>
   </thead>
    <tbody>
        {
        for $uri in cts:uri-match('/admin/*.xqy')
        let $this-view := $view-description-doc/view[uri=$uri]
        return
        if ($uri = '/admin/index.xqy')
           then ()
           else
           <tr>
              <td>
                <a href="{$uri}">{substring-after($uri, '/admin/')}</a>
              </td>
              <td>
                 {$this-view/description/text()}
              </td>
              <!-- <td>{$this-view/author/text()}</td> -->
           </tr>
        
        }
    </tbody>
</table>
Elapsed Time = {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.
</div>

return style:assemble-page($title, $content)