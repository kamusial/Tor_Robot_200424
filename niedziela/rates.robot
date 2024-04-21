*** Settings ***
Library  RequestsLibrary
Library  date_comparison.py
Library  ddos.py
Library  response_validator.py

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

Should Raise 400 For Incorrect Inquiry
    ${response}  GET  https://api.nbp.pl/api/cenyzlota/1999-02-01/1999-01-01  expected_status=400
    Should Contain    ${response.text}    Błędny zakres dat

Should Raise 400 For Exceeded Date Range
    ${response}  GET  https://api.nbp.pl/api/cenyzlota/1999-02-01/2023-01-01  expected_status=400
    Should Contain    ${response.text}    Przekroczony limit

DDOS Attack Should Be Blocked
    [Documentation]    Ten test nie zadziała :(
    ...  Synchroniczne requesty są zbyt powolne.
    [Tags]    Bad
    FOR   ${i}  IN RANGE  100
        ${response}   GET  https://api.nbp.pl/api/exchangerates/tables/a/
        Pass Execution If    ${response.status_code} == 429   DDOS attack blocked correctly
        Log To Console    ${i}
    END
    Fail    Got valid status code for all requests in DDOS attack.
    
DDOS Attack Should Be Blocked 2
    ${responses}  Ddos    https://api.nbp.pl/api/exchangerates/tables/a/   count=300
    FOR   ${response}  IN  @{responses}
        Pass Execution If    ${response.status_code} == 429   DDOS attack blocked correctly
    END
    Fail    Got valid status code for all requests in DDOS attack.
    
Response Structure Should Be Correct
    ${response}   GET  https://api.nbp.pl/api/exchangerates/tables/a/
    Validate Table A Structure   ${response}
