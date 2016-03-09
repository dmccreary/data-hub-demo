xquery version "1.0-ml";
import module namespace style="http://westacademic.com/styles" at "/modules/style.xqy";

let $title := 'Ontology Search'

let $content :=
<div class="content">
   <form action="search-service.xqy" class="form-inline">
      <label>Search:</label>
      <input name="q" type="text" class="search form-control"/>
      <br/>
      <button type="submit" class="btn btn-primary">Search</button>
   </form>
</div>

return style:assemble-page($title, $content)