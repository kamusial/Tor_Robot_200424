*** Settings ***
Library  RequestsLibrary
Library  date_comparison.py

*** Test Cases ***
Last Dollar Rate Should Be Available
    ${response}  GET    https://api.nbp.pl/api/exchangerates/rates/a/usd/last/
    ${dictionary}  Evaluate    $response.json()
    Log To Console    ${dictionary["rates"][0]["mid"]}

API Response Should Respect Provided Date Range
    ${start}  Set Variable    2022-01-05
    ${end}    Set Variable    2022-02-15
    ${response}  GET  https://api.nbp.pl/api/exchangerates/rates/a/gbp/${start}/${end}/
    ${dictionary}  Evaluate    $response.json()
    FOR  ${rate_dict}   IN   @{dictionary["rates"]}
        ${is_within_range}  Is Date Within Range    ${rate_dict["effectiveDate"]}   ${start}  ${end}
        Should Be True    ${is_within_range}
    END

Should Raise 404 For Date Range With No Records
    ${response}  GET  https://api.nbp.pl/api/cenyzlota/1980-01-01/1980-01-31/   expected_status=404
    Should Contain    ${response.text}    Brak danych
