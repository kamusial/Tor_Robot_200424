*** Settings ***
Library    SeleniumLibrary

*** Variables ***


*** Keywords ***


*** Test Cases ***
Test 1
    open browser    https://pl.wikipedia.org/    chrome    #executable_path=sciezka do sterownika
    sleep    3
    click element    id:pt-login-2
    sleep    3

    close browser