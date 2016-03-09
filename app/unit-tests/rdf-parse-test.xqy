xquery version "1.0-ml"; 
 
import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace v="http://www.w3.org/2006/vcard/";

(: note that we must wrap the sem:rdf-parse() function in a element for it to render in oXygen :)
<sem:triples xmlns="http://marklogic.com/semantics">
{
   sem:rdf-parse(
   <rdf:Description rdf:about="urn:isbn:006251587X">
     <dc:title>Weaving the Web</dc:title>
     <dc:creator rdf:resource="http://www.w3.org/People/Berners-Lee/card#i"/>
   </rdf:Description>,
   "rdfxml")
}
</sem:triples>