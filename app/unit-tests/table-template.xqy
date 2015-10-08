xquery version "1.0-ml";

import module namespace style = "http://marklogic.com/data-hub/style" at "/modules/style.xqy";

let $title := 'Last Modified Files'

let $content :=
<div class="continer">
   <div class="row">
     <div class="col-md-4">
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
               <tr>
                  <th>Col 1</th>
                  <th>Col 2</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td>Row 1 Col 1</td>
                  <td class="number">123</td>
               </tr>
               <tr>
                  <td>Row 2 Col 1</td>
                  <td class="number">123</td>
               </tr>
            </tbody>
        </table>
      </div>
   </div>
</div>

return style:assemble-page($title, $content)