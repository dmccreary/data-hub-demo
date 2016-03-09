xquery version "1.0-ml";

(: example code that converts a date in 05-Jan-2016 format to xs:date format :)

let $date := '05-Jan-2016'
let $day-of-month := substring($date, 1, 2)
let $month-string := lower-case(substring($date, 4, 3))
let $year := substring($date, 8, 4)

let $months := ('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec')
(: this returns the number of the position of the input in the sequence :)
let $month-position := fn:index-of($months, $month-string)
let $month-position-padded :=
   if ($month-position < 10)
      then concat('0', string($month-position))
      else string($month-position)

let $valid-date :=
   concat($year, '-', $month-position-padded, '-', $day-of-month)

return $valid-date