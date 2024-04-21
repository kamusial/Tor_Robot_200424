*** Settings ***
Library  RequestsLibrary

*** Test Cases ***
Last Dollar Rate
    ${response}  GET    https://api.nbp.pl/api/exchangerates/rates/a/usd/last/
    ${dictionary}  Evaluate    $response.json()
    Log To Console    ${dictionary["rates"][0]["mid"]}
    