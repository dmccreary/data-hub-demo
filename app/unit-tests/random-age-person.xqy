(: generate a random age from 0 to 80 years old :)
let $date := xs:date("1950-01-01") + xdmp:random(10000) * xs:dayTimeDuration("P1D")
return
<results>
  {$date}
</results>

