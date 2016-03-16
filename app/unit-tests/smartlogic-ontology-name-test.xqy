import module namespace s = "http://marklogic.com/skos-xs-util" at "/modules/skos-xl-util.xqy";

let $title := 'list all concpts'
(: returns a sequences of URIs for all the top concepts in the taxonomy :)
return
s:concepts('/data/smartlogic-models/cycling-taxonomy-v2.rdf')