declare namespace skosxl = "http://www.w3.org/2008/05/skos-xl#";

(: test of skipping through a prefLabel to get the real label :)

let $ontology :=
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
xmlns:dcterms="http://purl.org/dc/terms/" 
xmlns:owl="http://www.w3.org/2002/07/owl#" 
xmlns:sioc="http://rdfs.org/sioc/ns#" 
xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
xmlns:teamwork="http://topbraid.org/teamwork#" 
xmlns:example="http://proto.smartlogic.com/example#" 
xmlns:sem="http://www.smartlogic.com/2014/08/semaphore-core#" 
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
xmlns:skosxl="http://www.w3.org/2008/05/skos-xl#" 
xmlns:spin="http://spinrdf.org/spin#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"> 
  
    <rdf:Description rdf:about="http://proto.smartlogic.com/example#Semaphore">
       <skosxl:prefLabel rdf:resource="http://proto.smartlogic.com/example#Semaphore_"/>
    </rdf:Description>
  
    <rdf:Description rdf:about="http://proto.smartlogic.com/example#Semaphore_">
      <rdf:type rdf:resource="http://www.w3.org/2008/05/skos-xl#Label"/>
      <skosxl:literalForm>Semaphore</skosxl:literalForm>
     </rdf:Description>
     
  </rdf:RDF>
  
  let $uri := 'http://proto.smartlogic.com/example#Semaphore'
  
  let $pref-label-uri := $ontology/rdf:Description[@rdf:about=$uri]/skosxl:prefLabel/@rdf:resource
  let $actual := $ontology/rdf:Description[@rdf:about=$pref-label-uri]/skosxl:literalForm/text()
  let $expected := 'Semaphore'
  let $pass := ($expected = $actual)

 return
 <test-case name="test-prefLabel-lookup">
    <expected>{$expected}</expected>
    <actual>{$actual}</actual>
    <pass>{$pass}</pass>
 </test-case>
  