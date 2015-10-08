xquery version "1.0-ml";

let $template := 
<person xmlns="http://marklogic.com/data-hub/canonical/person/v1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://marklogic.com/data-hub/canonical/person/v1 file:/Users/dmccrear/Documents/workspace/data-hub-demo/app/schemas/person-canonical.xsd">
    <identifiers>
        <identifier>
            <source-system-code/>
            <source-system-id/>
            <last-updated-datetime/>
        </identifier>
    </identifiers>
    <name>
        <person-given-name></person-given-name>
        <person-middle-name></person-middle-name>
        <person-middle-name> </person-middle-name>
        <person-family-name> </person-family-name>
        <person-prefix> </person-prefix>
        <person-suffix> </person-suffix>
    </name>
    <addresses>
        <address>
            <street-text> </street-text>
            <us-state-code> </us-state-code>
            <country-code> </country-code>
        </address>
        <address>
            <street-text> </street-text>
            <us-state-code> </us-state-code>
            <country-code> </country-code>
        </address>
    </addresses>
    <person-birth-date>1970-01-01</person-birth-date>
    <phone-numbers>
        <phone>
            <phone-type-code> </phone-type-code>
            <phone-number> </phone-number>
        </phone>
        <phone>
            <phone-type-code> </phone-type-code>
            <phone-number> </phone-number>
        </phone>
    </phone-numbers>
    <person-gender-code> </person-gender-code>
    <person-ethnicity-code> </person-ethnicity-code>
    <person-race-code> </person-race-code>
</person>
