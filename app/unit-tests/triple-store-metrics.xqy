xquery version "1.0-ml";

declare namespace ctstvs = "cts:triple-value-statistics";

let $triple-value-statistics := cts:triple-value-statistics()

return
<triple-store-metrics>
  <doc-count>{format-number(xdmp:estimate(/), '#,###')}</doc-count>
  <distinct-triple-count>{format-number(number(cts:triple-value-statistics()/@count), '#,###')}</distinct-triple-count>
  <unique-subjects>{format-number(number($triple-value-statistics/@unique-subjects), '#,###')}</unique-subjects>
  <unique-predicates>{format-number(number($triple-value-statistics/@unique-predicates), '#,###')}</unique-predicates>
  <unique-unique-objects>{format-number(number($triple-value-statistics/@unique-objects), '#,###')}</unique-unique-objects>
</triple-store-metrics>